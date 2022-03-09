# Create the replica key using the primary's arn.
resource "aws_kms_replica_key" "replica" {
  for_each = { for k, v in var.replica : k => v if var.replica_region != "" }
  provider = aws.replica

  deletion_window_in_days = each.value["deletion_window_in_days"]
  primary_key_arn         = aws_kms_key.primary.arn
  policy                  = data.aws_iam_policy_document.kms_policy.json

  tags = merge(
    var.tags,
    {
      "Multi-Region" = "true",
      "Primary"      = "false"
    }
  )
}

# Add an alias to the replica key
resource "aws_kms_alias" "replica" {
  for_each = { for k, v in var.replica : k => v if var.replica_region != "" }
  provider = aws.replica

  name          = aws_kms_alias.primary.name
  target_key_id = aws_kms_replica_key.replica["secondary"].key_id
}