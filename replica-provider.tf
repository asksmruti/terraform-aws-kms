provider "aws" {
  alias   = "replica"
  region  = var.replica_region
  profile = var.replica_aws_profile
}