# Provider specific variable
variable "replica_region" {
  type        = string
  default     = ""
  description = "Specifies KMS replica key region"
}

variable "deletion_window_in_days" {
  type        = number
  default     = 7
  description = "Duration in days after which the key is deleted after destruction of the resource"
}

variable "enable_key_rotation" {
  type        = bool
  default     = true
  description = "Specifies whether key rotation is enabled"
}

variable "description" {
  type        = string
  default     = "Parameter Store KMS master key"
  description = "The description of the key as viewed in AWS console"
}

variable "alias" {
  type        = string
  description = "The display name of the alias."
}

variable "key_usage" {
  type        = string
  default     = "ENCRYPT_DECRYPT"
  description = "Specifies the intended use of the key. Valid values: `ENCRYPT_DECRYPT` or `SIGN_VERIFY`."
}

variable "customer_master_key_spec" {
  type        = string
  default     = "SYMMETRIC_DEFAULT"
  description = "Specifies whether the key contains a symmetric key or an asymmetric key pair and the encryption algorithms or signing algorithms that the key supports. Valid values: `SYMMETRIC_DEFAULT`, `RSA_2048`, `RSA_3072`, `RSA_4096`, `ECC_NIST_P256`, `ECC_NIST_P384`, `ECC_NIST_P521`, or `ECC_SECG_P256K1`."
}

variable "multi_region" {
  type        = bool
  default     = true
  description = "Indicates whether the KMS key is a multi-Region (true) or regional (false) key."
}

variable "is_enabled" {
  type        = bool
  default     = true
  description = "Specifies whether the key is enabled"
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "replica" {
  type = map(object({
    deletion_window_in_days = number
  }))

  default = {
    "secondary" = {
      description             = "Parameter Store KMS replica key"
      deletion_window_in_days = 7
    }
  }
  description = "Specifies variables for KMS replica key"
}

### KMS Policy variables

variable "admin_user_list" {
  description = "List of admin users - full access to KMS"
  type        = list(string)
  default     = []

}
variable "power_user_list" {
  description = "List of power users arn who can grant/revoke access to users"
  type        = list(string)
  default     = []
}

variable "user_list" {
  description = "List of users arn who can access and use the KMS key"
  type        = list(string)
  default     = []
}
