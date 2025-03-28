variable "create" {
  type        = bool
  description = "Whether to create the Timestream database"
  default     = true
}

variable "database_name" {
  type        = string
  description = "The name of the Timestream database"
}

variable "kms_key_id" {
  type        = string
  description = "The ARN of the KMS key to be used to encrypt the data stored in the database"
  default     = null
}

variable "database_tags" {
  type        = map(string)
  description = "Map of tags to assign to the database resource"
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "Map of tags to assign to this resource"
  default     = {}
}

variable "tables" {
  type        = any
  description = "List of tables and their configurations"
  default     = {}
}
