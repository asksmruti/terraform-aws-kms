output "primary-kms-key-arn" {
  value       = aws_kms_key.primary.arn
  description = "KMS key arn"
}

output "primary-kms-key-id" {
  value       = aws_kms_key.primary.id
  description = "KMS key id"
}

output "primary-kms-key-dw" {
  value       = aws_kms_key.primary.deletion_window_in_days
  description = "The waiting period, specified in number of days. After the waiting period ends, AWS KMS deletes the KMS key. If you specify a value, it must be between 7 and 30, inclusive. If you do not specify a value, it defaults to 30. If the KMS key is a multi-Region primary key with replicas, the waiting period begins when the last of its replica keys is deleted. Otherwise, the waiting period begins immediately."
}

output "primary-key-alias-arn" {
  value       = aws_kms_alias.primary.arn
  description = "KMS key alias arn"
}

output "primary-key-alias-id" {
  value       = aws_kms_alias.primary.id
  description = "KMS key alias id"
}

output "describe-key" {
  value       = data.aws_kms_key.describe_key
  description = "Describe KMS key"
}
