module "band_events_table" {
  source    = "terraform-aws-modules/dynamodb-table/aws"

  name      = "BandEvents"
  hash_key  = "hash"
  range_key = "range"

  attributes = [
    {
      name = "hash"
      type = "S"
    },
    {
      name = "range"
      type = "S"
    }
  ]

  tags = {
    Terraform   = "true"
  }
}