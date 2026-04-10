##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

locals {
  secret_name = format("%s/mongodbatlas/%s/admin-user-credentials",
    replace(local.secret_store_path, "/", "-"),
    module.cluster.cluster_name
  )
}

resource "google_secret_manager_secret" "atlas_cred" {
  count     = try(var.settings.admin_user.enabled, false) ? 1 : 0
  secret_id = local.secret_name
  project   = data.google_project.current.project_id

  replication {
    dynamic "user_managed" {
      for_each = try(var.settings.admin_user.secret_replication_locations, []) != [] ? [1] : []
      content {
        dynamic "replicas" {
          for_each = try(var.settings.admin_user.secret_replication_locations, [data.google_client_config.current.region])
          content {
            location = replicas.value
            dynamic "customer_managed_encryption" {
              for_each = try(var.settings.admin_user.kms_key_id, "") != "" ? [var.settings.admin_user.kms_key_id] : []
              content {
                kms_key_name = customer_managed_encryption.value
              }
            }
          }
        }
      }
    }
    dynamic "auto" {
      for_each = try(var.settings.admin_user.secret_replication_locations, []) == [] ? [1] : []
      content {
        dynamic "customer_managed_encryption" {
          for_each = try(var.settings.admin_user.kms_key_id, "") != "" ? [var.settings.admin_user.kms_key_id] : []
          content {
            kms_key_name = customer_managed_encryption.value
          }
        }
      }
    }
  }

  labels = local.all_tags
}

resource "google_secret_manager_secret_version" "atlas_cred" {
  count       = try(var.settings.admin_user.enabled, false) ? 1 : 0
  secret      = google_secret_manager_secret.atlas_cred[0].id
  secret_data = jsonencode(module.cluster.cluster_credentials)

  lifecycle {
    ignore_changes = [
      secret_data
    ]
  }
}
