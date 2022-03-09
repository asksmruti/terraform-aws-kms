resource "aws_kms_key" "primary" {
  multi_region             = var.multi_region
  description              = var.description
  customer_master_key_spec = var.customer_master_key_spec
  is_enabled               = var.is_enabled
  enable_key_rotation      = var.enable_key_rotation
  policy                   = data.aws_iam_policy_document.kms_policy.json
  deletion_window_in_days  = var.deletion_window_in_days

  tags = merge(
    var.tags,
    {
      "Multi-Region" = "true",
      "Primary"      = "true"
    }
  )
}

# Add an alias to the primary key
resource "aws_kms_alias" "primary" {
  name          = "alias/${var.alias}"
  target_key_id = aws_kms_key.primary.key_id
}

data "aws_kms_key" "describe_key" {
  key_id = aws_kms_key.primary.key_id
}