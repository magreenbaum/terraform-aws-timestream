# terraform-aws-timestream

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.35 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.35 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_timestreamwrite_database.database](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/timestreamwrite_database) | resource |
| [aws_timestreamwrite_table.table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/timestreamwrite_table) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | n/a | `bool` | `true` | no |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | The name of the Timestream database | `string` | n/a | yes |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The ARN of the KMS key to be used to encrypt the data stored in the database | `string` | `null` | no |
| <a name="input_tables"></a> [tables](#input\_tables) | n/a | `any` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to assign to this resource | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_database_arn"></a> [database\_arn](#output\_database\_arn) | The ARN that uniquely identifies this database |
| <a name="output_database_id"></a> [database\_id](#output\_database\_id) | The name of the Timestream database |
| <a name="output_database_tags"></a> [database\_tags](#output\_database\_tags) | A map of tags assigned to the resource |
| <a name="output_kms_key_id"></a> [kms\_key\_id](#output\_kms\_key\_id) | The ARN of the KMS key used to encrypt the data stored in the database |
| <a name="output_table_count"></a> [table\_count](#output\_table\_count) | The total number of tables found within the Timestream database |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
