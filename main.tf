resource "aws_timestreamwrite_database" "database" {
  count = var.create ? 1 : 0

  # Database name should be a minimum length of 3, maximum length of 64
  database_name = var.database_name

  # If the KMS key ID is not specified, the database will be encrypted with a Timestream managed KMS key located in your account.
  kms_key_id = var.kms_key_id
  tags       = merge(var.tags, var.database_tags)
}

resource "aws_timestreamwrite_table" "table" {
  for_each      = { for k, v in var.tables : k => v if length(var.tables) > 0 }
  database_name = aws_timestreamwrite_database.database[0].id
  table_name    = try(each.value.table_name, each.key)
  tags          = merge(var.tags, try(each.value.tags, {}))

  dynamic "magnetic_store_write_properties" {
    for_each = try([each.value.magnetic_store_write_properties], [])

    content {
      enable_magnetic_store_writes = try(magnetic_store_write_properties.value.enabled, false)

      dynamic "magnetic_store_rejected_data_location" {
        for_each = try([magnetic_store_write_properties.value.magnetic_store_rejected_data_location], [])

        content {
          s3_configuration {
            bucket_name       = try(magnetic_store_rejected_data_location.value.bucket_name, null)
            encryption_option = try(magnetic_store_rejected_data_location.value.encryption_option, null)
            kms_key_id        = try(magnetic_store_rejected_data_location.value.kms_key_id, null)
            object_key_prefix = try(magnetic_store_rejected_data_location.value.object_key_prefix, null)
          }
        }
      }
    }
  }

  dynamic "retention_properties" {
    for_each = try([each.value.retention_properties], [])

    content {
      magnetic_store_retention_period_in_days = retention_properties.value.magnetic_store_retention_period_in_days
      memory_store_retention_period_in_hours  = retention_properties.value.memory_store_retention_period_in_hours
    }
  }

  dynamic "schema" {
    for_each = try([each.value.schema], [])

    content {
      dynamic "composite_partition_key" {
        for_each = try([schema.value.composite_partition_key], [])

        content {
          enforcement_in_record = try(composite_partition_key.value.enforcement_in_record, null)
          name                  = try(composite_partition_key.value.name, null)
          type                  = composite_partition_key.value.type
        }
      }
    }
  }
}
