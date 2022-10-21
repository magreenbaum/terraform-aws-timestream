provider "aws" {
  region = "us-west-2"
}

module "timestream" {
  source        = "../../"
  database_name = "test"

  tables = [
    {
      table_name = "test"
    },
    {
      table_name = "test1"
      magnetic_store_writes = {
        enabled = true
        rejected_data_location = {
          bucket_name       = "test"
          encryption_option = "SSE_S3"
        }
      }
      retention_properties = {
        magnetic_store_retention_period_in_days = 3
        memory_store_retention_period_in_hours  = 24
      }
    }
  ]

}
