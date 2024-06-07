<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloud_spanner"></a> [cloud\_spanner](#module\_cloud\_spanner) | ../modules/spanner-instance | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instances"></a> [instances](#input\_instances) | n/a | <pre>map(object({<br>  project_id  = string<br>  instance_display_name = optional(string)<br>  instance_size = map(string)<br>  instance_config = string<br>  instance_labels = optional(map(string))<br>  instance_iam = optional(list(string))<br>  create_instance = optional(bool)<br>}))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_spanner_instance_details"></a> [spanner\_instance\_details](#output\_spanner\_instance\_details) | n/a |
<!-- END_TF_DOCS -->