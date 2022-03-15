locals {
  replica_region = var.replica_region != "" ? var.replica_region : "eu-west-1"
}

provider "aws" {
  alias  = "replica"
  region = local.replica_region
}
