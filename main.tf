resource "aws_timestreamwrite_database" "database" {
  count = var.create ? 1 : 0

  # Database name should be a minimum length of 3, maximum length of 64
  database_name = var.database_name

  # If the KMS key ID is not specified, the database will be encrypted with a Timestream managed KMS key located in your account.
  kms_key_id = var.kms_key_id
  tags       = var.tags
}

resource "aws_timestreamwrite_table" "table" {
  for_each      = { for k, v in var.tables : k => v if length(var.tables) > 0 }
  database_name = aws_timestreamwrite_database.database[0].id
  table_name    = each.value.table_name
  tags          = var.tags

  dynamic "magnetic_store_write_properties" {
    for_each = length(lookup(each.value, "magnetic_store_writes", {})) > 0 ? [each.value.magnetic_store_writes] : []
    content {
      enable_magnetic_store_writes = lookup(magnetic_store_write_properties.value, "enabled", false)
      dynamic "magnetic_store_rejected_data_location" {
        for_each = length(lookup(magnetic_store_write_properties.value, "rejected_data_location", {})) > 0 ? [
          magnetic_store_write_properties.value.rejected_data_location
        ] : []
        content {
          s3_configuration {
            bucket_name       = lookup(magnetic_store_rejected_data_location.value, "bucket_name", null)
            encryption_option = lookup(magnetic_store_rejected_data_location.value, "encryption_option", null)
            kms_key_id        = lookup(magnetic_store_rejected_data_location.value, "kms_key_id", null)
            object_key_prefix = lookup(magnetic_store_rejected_data_location.value, "object_key_prefix", null)
          }
        }
      }
    }
  }

  dynamic "retention_properties" {
    for_each = length(lookup(each.value, "retention_properties", {})) > 0 ? [each.value.retention_properties] : []
    content {
      magnetic_store_retention_period_in_days = lookup(retention_properties.value, "magnetic_store_retention_period_in_days", null)
      memory_store_retention_period_in_hours  = lookup(retention_properties.value, "memory_store_retention_period_in_hours", null)
    }
  }
}
