data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "kms_policy" {
  statement {
    sid       = "Enable IAM User Permissions"
    effect    = "Allow"
    actions   = ["kms:*"]
    resources = ["*"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }

  dynamic "statement" {
    for_each = length(var.admin_user_list) > 0 ? [1] : []
    content {
      sid    = "Allow access for Key Administrators"
      effect = "Allow"
      actions = [
        "kms:Create*",
        "kms:Describe*",
        "kms:Enable*",
        "kms:List*",
        "kms:Put*",
        "kms:Update*",
        "kms:Revoke*",
        "kms:Disable*",
        "kms:Get*",
        "kms:Delete*",
        "kms:TagResource",
        "kms:UntagResource",
        "kms:ScheduleKeyDeletion",
        "kms:CancelKeyDeletion"
      ]
      resources = ["*"]

      principals {
        type        = "AWS"
        identifiers = var.admin_user_list
      }
    }
  }

  dynamic "statement" {
    for_each = length(var.user_list) > 0 ? [1] : []
    content {
      sid    = "Allow use of the key"
      effect = "Allow"
      actions = [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:DescribeKey"
      ]
      resources = ["*"]

      principals {
        type        = "AWS"
        identifiers = var.user_list
      }
    }
  }

  dynamic "statement" {
    for_each = length(var.power_user_list) > 0 ? [1] : []
    content {
      sid    = "Allow attachment of persistent resources"
      effect = "Allow"
      actions = [
        "kms:CreateGrant",
        "kms:ListGrants",
        "kms:RevokeGrant"
      ]
      resources = ["*"]

      principals {
        type        = "AWS"
        identifiers = var.user_list
      }

      condition {
        test     = "Bool"
        variable = "kms:GrantIsForAWSResource"
        values   = ["true"]
      }
    }
  }
}
