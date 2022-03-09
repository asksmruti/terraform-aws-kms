<!-- BEGIN_TF_DOCS -->
## Multi regional KMS key

This module can be used to generate multi-region or single-region customer managed keys(CMK) KMS key.
A ploicy can also be generated with with admin/power and readonly user permission by providing the required arn of user or role. 
It uses default key material origin i.e. AWS/KMS. However, it can be extended to use external key material.  

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws.replica"></a> [aws.replica](#provider\_aws.replica) | n/a |

## Modules

The module can be used as below - 
- To generate KMS key in single region
```
  module "generate-kms-key" {
    source              = "git@github.com:asksmruti/terraform-aws-kms.git"
    alias               = "test-4"
  }
```

- To generate KMS key in multiple region

```
  module "generate-kms-key" {
    source              = "git@github.com:asksmruti/terraform-aws-kms.git"
    alias               = "test-4"
    replica_aws_profile = "temp_bpi-dev"
    replica_region      = "eu-west-2"
  }
```
- Generate policy and attached to KMS key
```
  module "generate-kms-key" {
    source              = "git@github.com:asksmruti/terraform-aws-kms.git"
    alias               = "test-4"
    admin_user_list = ["arn:aws:iam::xxxxxxx:role/user-roles/Admins"]
    user_list = ["arn:aws:iam::xxxxxxx:role/user-roles/Developers"]
  }
```
## Resources

| Name | Type |
|------|------|
| [aws_kms_alias.primary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_alias.replica](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.primary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_replica_key.replica](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_replica_key) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.kms_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_kms_key.describe_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_key) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_user_list"></a> [admin\_user\_list](#input\_admin\_user\_list) | List of admin users - full access to KMS | `list(string)` | `[]` | no |
| <a name="input_alias"></a> [alias](#input\_alias) | The display name of the alias. | `string` | n/a | yes |
| <a name="input_customer_master_key_spec"></a> [customer\_master\_key\_spec](#input\_customer\_master\_key\_spec) | Specifies whether the key contains a symmetric key or an asymmetric key pair and the encryption algorithms or signing algorithms that the key supports. Valid values: `SYMMETRIC_DEFAULT`, `RSA_2048`, `RSA_3072`, `RSA_4096`, `ECC_NIST_P256`, `ECC_NIST_P384`, `ECC_NIST_P521`, or `ECC_SECG_P256K1`. | `string` | `"SYMMETRIC_DEFAULT"` | no |
| <a name="input_deletion_window_in_days"></a> [deletion\_window\_in\_days](#input\_deletion\_window\_in\_days) | Duration in days after which the key is deleted after destruction of the resource | `number` | `7` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the key as viewed in AWS console | `string` | `"Parameter Store KMS master key"` | no |
| <a name="input_enable_key_rotation"></a> [enable\_key\_rotation](#input\_enable\_key\_rotation) | Specifies whether key rotation is enabled | `bool` | `true` | no |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Specifies whether the key is enabled | `bool` | `true` | no |
| <a name="input_key_usage"></a> [key\_usage](#input\_key\_usage) | Specifies the intended use of the key. Valid values: `ENCRYPT_DECRYPT` or `SIGN_VERIFY`. | `string` | `"ENCRYPT_DECRYPT"` | no |
| <a name="input_multi_region"></a> [multi\_region](#input\_multi\_region) | Indicates whether the KMS key is a multi-Region (true) or regional (false) key. | `bool` | `true` | no |
| <a name="input_power_user_list"></a> [power\_user\_list](#input\_power\_user\_list) | List of power users arn who can grant/revoke access to users | `list(string)` | `[]` | no |
| <a name="input_replica"></a> [replica](#input\_replica) | Specifies variables for KMS replica key | <pre>map(object({<br>    deletion_window_in_days = number<br>  }))</pre> | <pre>{<br>  "secondary": {<br>    "deletion_window_in_days": 7,<br>    "description": "Parameter Store KMS replica key"<br>  }<br>}</pre> | no |
| <a name="input_replica_aws_profile"></a> [replica\_aws\_profile](#input\_replica\_aws\_profile) | Provide aws profile for replica aws provider | `string` | `"default"` | no |
| <a name="input_replica_region"></a> [replica\_region](#input\_replica\_region) | Specifies KMS replica key region | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_user_list"></a> [user\_list](#input\_user\_list) | List of users arn who can access and use the KMS key | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_describe-key"></a> [describe-key](#output\_describe-key) | Describe KMS key |
| <a name="output_primary-key-alias-arn"></a> [primary-key-alias-arn](#output\_primary-key-alias-arn) | KMS key alias arn |
| <a name="output_primary-key-alias-id"></a> [primary-key-alias-id](#output\_primary-key-alias-id) | KMS key alias id |
| <a name="output_primary-kms-key-arn"></a> [primary-kms-key-arn](#output\_primary-kms-key-arn) | KMS key arn |
| <a name="output_primary-kms-key-dw"></a> [primary-kms-key-dw](#output\_primary-kms-key-dw) | The waiting period, specified in number of days. After the waiting period ends, AWS KMS deletes the KMS key. If you specify a value, it must be between 7 and 30, inclusive. If you do not specify a value, it defaults to 30. If the KMS key is a multi-Region primary key with replicas, the waiting period begins when the last of its replica keys is deleted. Otherwise, the waiting period begins immediately. |
| <a name="output_primary-kms-key-id"></a> [primary-kms-key-id](#output\_primary-kms-key-id) | KMS key id |
<!-- END_TF_DOCS -->