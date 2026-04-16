##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

locals {
  hoop_enabled     = try(var.settings.hoop.enabled, false) && try(var.settings.admin_user.enabled, false)
  hoop_enterprise  = local.hoop_enabled && !try(var.settings.hoop.community, true)
  hoop_secret_name = lower(replace(
    format("%s/mongodbatlas/%s/admin-conn-string",
      replace(local.secret_store_path, "/", "-"),
      module.cluster.cluster_name
    ),
    "/[^a-zA-Z0-9_-]/", "-"
  ))
}

# Standalone connection-string secret required for Hoop enterprise (_envs/gcp/<secret-id>).
# GCP Secret Manager does not support sub-key access; the full credentials JSON cannot be used directly.
resource "google_secret_manager_secret" "atlas_cred_conn_string" {
  count     = local.hoop_enterprise ? 1 : 0
  secret_id = local.hoop_secret_name
  project   = data.google_project.current.project_id

  replication {
    auto {}
  }

  labels = local.all_tags
}

resource "google_secret_manager_secret_version" "atlas_cred_conn_string" {
  count       = local.hoop_enterprise ? 1 : 0
  secret      = google_secret_manager_secret.atlas_cred_conn_string[0].id
  secret_data = module.cluster.cluster_credentials.connection_string

  lifecycle {
    ignore_changes = [secret_data]
  }
}

output "hoop_connections" {
  description = <<-EOD
    Hoop connection definition for the cluster admin user.
    Returns null in community mode — GCP Secret Manager has no native Hoop community provider.
    Enterprise mode: pass directly as the `connections` input to terraform-module-hoop-connection.
    Note: terraform-module-hoop-connection manages connections via the Hoop provider; ensure your
    Hoop agent has access to retrieve secrets from GCP Secret Manager.
  EOD
  value = local.hoop_enterprise ? {
    "admin" = {
      name           = "mongo-db-${lower(module.cluster.cluster_name)}-admin"
      agent_id       = var.settings.hoop.agent_id
      type           = "database"
      subtype        = "mongodb"
      tags           = try(var.settings.hoop.tags, {})
      access_control = toset(try(var.settings.hoop.access_control, []))
      access_modes = {
        connect  = "enabled"
        exec     = "enabled"
        runbooks = "enabled"
        schema   = "enabled"
      }
      import  = try(var.settings.hoop.import, false)
      secrets = {
        "envvar:CONNECTION_STRING" = "_envs/gcp/${google_secret_manager_secret.atlas_cred_conn_string[0].secret_id}"
      }
    }
  } : null

  precondition {
    condition     = !local.hoop_enterprise || try(var.settings.hoop.agent_id, "") != ""
    error_message = "settings.hoop.agent_id must be set (as a Hoop agent UUID) when settings.hoop.enabled is true and settings.hoop.community is false."
  }
}
