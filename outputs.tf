output "database_id" {
  description = "The name of the Timestream database"
  value = try(aws_timestreamwrite_database.database[0].id, "")
}

output "database_arn" {
  description = "The ARN that uniquely identifies this database"
  value = try(aws_timestreamwrite_database.database[0].arn, "")
}

output "kms_key_id" {
  description = "The ARN of the KMS key used to encrypt the data stored in the database"
  value = try(aws_timestreamwrite_database.database[0].kms_key_id, "")
}

output "table_count" {
  description = "The total number of tables found within the Timestream database"
  value = try(aws_timestreamwrite_database.database[0].table_count, "")
}

output "database_tags" {
  description = "A map of tags assigned to the resource"
  value = try(aws_timestreamwrite_database.database[0].tags_all, "")
}