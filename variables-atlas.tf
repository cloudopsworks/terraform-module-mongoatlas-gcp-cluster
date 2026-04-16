##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

variable "name_prefix" {
  description = "Prefix for the name of the resources"
  type        = string
  default     = ""
}

variable "name" {
  description = "Name of the resource"
  type        = string
  default     = ""
}

variable "project_id" {
  description = "(optional) The ID of the Atlas project where the cluster will be created"
  type        = string
  default     = ""
}

variable "project_name" {
  description = "(optional) The name of the Atlas project where the cluster will be created"
  type        = string
  default     = ""
}

##
# Variable entries as YAML
# settings:
#   cluster_type: "REPLICASET"          # (Optional) REPLICASET | SHARDED | GEOSHARDED. Default: "REPLICASET"
#   major_version: 7.0                  # (Optional) MongoDB major version. Default: null (uses Atlas default)
#   termination_protection: true        # (Optional) Enable termination protection. Default: null
#   version_release: "LTS"              # (Optional) LTS | CONTINUOUS. Default: "LTS"
#   encryption_at_rest_enabled: false   # (Optional) Enable encryption at rest. Default: false
#   encryption_at_rest_provider: "GCP"  # (Optional) AWS | GCP | AZURE. Default: "GCP" for this module
#   cloud_provider: "GCP"               # (Optional) Default cloud provider for backup export/copy. Default: "GCP" for this module
#   bi_connector:
#     enabled: false                    # (Optional) Enable BI Connector. Default: false
#     read_preference: "secondary"      # (Optional) primary | secondary | primaryPreferred | secondaryPreferred | nearest
#   admin_user:
#     enabled: false                    # (Optional) Create Atlas admin user. Default: false
#     username: "my-admin"              # (Optional) Username. Default: auto-generated
#     auth_database: "admin"            # (Optional) Authentication database. Default: "admin"
#     use_external_rotation: false      # (Optional) Use external rotation manager for the password. Default: false
#     rotation_lambda_name: ""          # (Optional) External rotator identifier (e.g. Lambda name). Required when use_external_rotation is true
#     rotation_period: 90               # (Optional) External rotation period in days. Default: 90
#     rotation_duration: "1h"           # (Optional) Duration for external rotator execution. Default: "1h"
#     password_rotation_period: 90      # (Optional) Terraform time_rotating period in days. Default: 90
#     kms_key_id: "projects/.../..."    # (Optional) Google KMS crypto key resource name for Secret Manager CMEK
#     secret_replication_locations: []  # (Optional) List of GCP regions for user-managed replication. Default: [] (auto replication)
#   advanced:
#     default_write_concern: "majority" # (Optional) Write concern. Default: null
#     javascript: false                 # (Optional) Enable JavaScript. Default: null
#     tls_protocol: "TLS1_2"           # (Optional) TLS1_0 | TLS1_1 | TLS1_2 | TLS1_3. Default: null
#     no_table_scan: false             # (Optional) Disable table scans. Default: null
#     oplog_size: 50                   # (Optional) Oplog size in MB. Default: null
#     oplog_retention: 30              # (Optional) Oplog retention in hours. Default: null
#     bi:
#       sample_size: 1000              # (Optional) BI Connector sample size. Default: null
#       refresh_interval: 60           # (Optional) BI Connector refresh interval in seconds. Default: null
#     transaction_lifetime: 30         # (Optional) Transaction lifetime in seconds. Default: null
#   backup:
#     enabled: false                   # (Optional) Enable cloud backup. Default: false
#     hour_of_day: 0                   # (Optional) Backup hour 0-23. Default: 0
#     minute_of_hour: 0                # (Optional) Backup minute 0-59. Default: 0
#     restore_window_days: 1           # (Optional) Restore window in days. Default: 1
#     auto_export: false               # (Optional) Enable automatic export. Default: null
#     export_prefix: false             # (Optional) Use org and group names in export prefix. Default: null
#     hourly:
#       interval: 6                    # (Optional) Frequency in hours. Default: 1
#       retention_unit: "days"         # (Optional) days. Default: "days"
#       retention_value: 2             # (Optional) Retention value. Default: 1
#     daily:
#       interval: 1                    # (Optional) Frequency. Default: 1
#       retention_unit: "days"         # (Optional) days. Default: "days"
#       retention_value: 7             # (Optional) Retention value. Default: 7
#     weekly:
#       interval: 1                    # (Optional) Day of week 1-7. Default: 1
#       retention_unit: "weeks"        # (Optional) weeks. Default: "weeks"
#       retention_value: 4             # (Optional) Retention value. Default: 4
#     monthly:
#       interval: 1                    # (Optional) Day of month 1-28. Default: 1
#       retention_unit: "months"       # (Optional) months. Default: "months"
#       retention_value: 12            # (Optional) Retention value. Default: 12
#     yearly:
#       interval: 1                    # (Optional) Month of year 1-12. Default: 1
#       retention_unit: "years"        # (Optional) years. Default: "years"
#       retention_value: 2             # (Optional) Retention value. Default: 2
#     export:
#       cloud_provider: "GCP"          # (Optional) Override export cloud provider. Default: "GCP" for this module
#       service_url: "gs://bucket"     # (Required for GCP) GCS bucket URL for backup export
#       role_id: "role-id"             # (Required for GCP) Atlas GCP service account role ID
#       bucket_name: ""                # (Required for AWS) S3 bucket name for backup export
#       iam_role_id: ""                # (Required for AWS) IAM role ID (assumed role) for bucket access
#       frequency_type: "daily"        # (Optional) hourly | daily | weekly | monthly. Default: "daily"
#     copy:
#       cloud_provider: "GCP"         # (Optional) Override copy cloud provider. Default: "GCP" for this module
#       frequencies: []               # (Optional) Frequencies to copy. Default: []
#       region_name: "CENTRAL_US"     # (Optional) Target Atlas region. Default: computed from GCP region
#       copy_oplogs: false            # (Optional) Copy oplogs. Default: false
#   global:
#     zone_name: "Zone 1"            # (Optional) Zone name for global clusters. Default: null
#     zone_id: ""                    # (Optional) Zone ID for global clusters. Default: null
#   regions:
#     - backing_provider: "GCP"      # (Optional) AWS | GCP | AZURE. Default: null
#       provider: "GCP"              # (Optional) AWS | GCP | AZURE | TENANT. Default: "TENANT"
#       region: "CENTRAL_US"         # (Optional) Atlas region for GCP. Default: computed from GCP region
#       priority: 7                  # (Optional) Electable node priority 1-7. Default: 7
#       electable:
#         size: "M10"                # (Optional) Instance size. Default: "M2"
#         count: 3                   # (Optional) Node count. Default: null
#         disk_size: 100             # (Optional) Disk size in GB. Default: null
#         iops: 3000                 # (Optional) Provisioned IOPS. Default: null
#         volume_type: "STANDARD"    # (Optional) Disk volume type. Default: null
#       analytics:
#         size: "M10"                # (Optional) Analytics instance size. Default: "M2"
#         count: 1                   # (Optional) Node count. Default: null
#         disk_size: 100             # (Optional) Disk size in GB. Default: null
#         iops: 3000                 # (Optional) Provisioned IOPS. Default: null
#         volume_type: "STANDARD"    # (Optional) Disk volume type. Default: null
#       read_only:
#         size: "M10"                # (Optional) Read-only instance size. Default: "M2"
#         count: 0                   # (Optional) Node count. Default: null
#         disk_size: 100             # (Optional) Disk size in GB. Default: null
#         iops: 3000                 # (Optional) Provisioned IOPS. Default: null
#         volume_type: "STANDARD"    # (Optional) Disk volume type. Default: null
#       auto_scaling:
#         disk: false                # (Optional) Enable disk auto-scaling. Default: false
#         compute: false             # (Optional) Enable compute auto-scaling. Default: false
#         max_size: "M40"            # (Optional) Maximum instance size. Default: null
#         min_size: "M10"            # (Optional) Minimum instance size. Default: null
#         scale_down: false          # (Optional) Enable scale-down. Default: false
#         analytics:
#           compute: false           # (Optional) Enable analytics compute auto-scaling. Default: false
#           disk: false              # (Optional) Enable analytics disk auto-scaling. Default: false
#           max_size: "M40"          # (Optional) Maximum analytics instance size. Default: null
#           min_size: "M10"          # (Optional) Minimum analytics instance size. Default: null
#           scale_down: false        # (Optional) Enable analytics scale-down. Default: false
#   hoop:
#     enabled: false                              # (Optional) Enable hoop_connections output. Default: false.
#     community: true                             # (Optional) true=community (returns null for GCP), false=enterprise (_envs/gcp/). Default: true.
#     agent_id: "xxxxxxxx-xxxx-xxxx-xxxx-xxxx"  # (Required when enabled+enterprise) Hoop.dev agent UUID.
#     tags: {}                                    # (Optional) Tags map for the Hoop connection. Default: {}.
#     access_control: []                          # (Optional) Access control group list. Default: [].
#     import: false                               # (Optional) Import existing Hoop connection instead of creating. Default: false.
variable "settings" {
  description = "Settings for the MongoDB Atlas cluster and GCP integrations"
  type        = any
  default     = {}
}

# run_hoop: false  # (Deprecated) No-op. Use hoop_connections output with terraform-module-hoop-connection instead. Default: false.
variable "run_hoop" {
  description = "DEPRECATED: No-op. Use the hoop_connections output with terraform-module-hoop-connection instead."
  type        = bool
  default     = false
}
