## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 7.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | ~> 7.0 |
| <a name="requirement_mongodbatlas"></a> [mongodbatlas](#requirement\_mongodbatlas) | ~> 2.1 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.4 |
| <a name="requirement_time"></a> [time](#requirement\_time) | ~> 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | ~> 7.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cluster"></a> [cluster](#module\_cluster) | git::https://github.com/cloudopsworks/terraform-module-mongoatlas-cluster.git | v1.2.1 |
| <a name="module_tags"></a> [tags](#module\_tags) | cloudopsworks/tags/local | 1.0.9 |

## Resources

| Name | Type |
|------|------|
| [google_secret_manager_secret.atlas_cred](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret.atlas_cred_conn_string](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret_version.atlas_cred](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_version) | resource |
| [google_secret_manager_secret_version.atlas_cred_conn_string](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_version) | resource |
| [google_client_config.current](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config) | data source |
| [google_project.current](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Extra tags to add to the resources | `map(string)` | `{}` | no |
| <a name="input_is_hub"></a> [is\_hub](#input\_is\_hub) | Is this a hub or spoke configuration? | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the resource | `string` | `""` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix for the name of the resources | `string` | `""` | no |
| <a name="input_org"></a> [org](#input\_org) | Organization details | <pre>object({<br/>    organization_name = string<br/>    organization_unit = string<br/>    environment_type  = string<br/>    environment_name  = string<br/>  })</pre> | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | (optional) The ID of the Atlas project where the cluster will be created | `string` | `""` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | (optional) The name of the Atlas project where the cluster will be created | `string` | `""` | no |
| <a name="input_run_hoop"></a> [run\_hoop](#input\_run\_hoop) | DEPRECATED: No-op. Use the hoop\_connections output with terraform-module-hoop-connection instead. | `bool` | `false` | no |
| <a name="input_settings"></a> [settings](#input\_settings) | Settings for the MongoDB Atlas cluster and GCP integrations | `any` | `{}` | no |
| <a name="input_spoke_def"></a> [spoke\_def](#input\_spoke\_def) | Spoke ID Number, must be a 3 digit number | `string` | `"001"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_admin_user"></a> [cluster\_admin\_user](#output\_cluster\_admin\_user) | n/a |
| <a name="output_cluster_connection_strings"></a> [cluster\_connection\_strings](#output\_cluster\_connection\_strings) | n/a |
| <a name="output_cluster_containers"></a> [cluster\_containers](#output\_cluster\_containers) | n/a |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | n/a |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | n/a |
| <a name="output_cluster_secret_id"></a> [cluster\_secret\_id](#output\_cluster\_secret\_id) | GCP Secret Manager secret ID storing the cluster admin credentials. |
| <a name="output_cluster_secret_name"></a> [cluster\_secret\_name](#output\_cluster\_secret\_name) | Full GCP Secret Manager resource name for the cluster admin credentials. |
| <a name="output_cluster_server_type"></a> [cluster\_server\_type](#output\_cluster\_server\_type) | n/a |
| <a name="output_cluster_state"></a> [cluster\_state](#output\_cluster\_state) | n/a |
| <a name="output_cluster_version"></a> [cluster\_version](#output\_cluster\_version) | n/a |
| <a name="output_hoop_connections"></a> [hoop\_connections](#output\_hoop\_connections) | Hoop connection definition for the cluster admin user.<br/>Returns null in community mode — GCP Secret Manager has no native Hoop community provider.<br/>Enterprise mode: pass directly as the `connections` input to terraform-module-hoop-connection.<br/>Note: terraform-module-hoop-connection manages connections via the Hoop provider; ensure your<br/>Hoop agent has access to retrieve secrets from GCP Secret Manager. |
