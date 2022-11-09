# AWS CloudTrail Terraform module

[<img src="https://lablabs.io/static/ll-logo.png" width=350px>](https://lablabs.io/)

We help companies build, run, deploy and scale software and infrastructure by embracing the right technologies and principles. Check out our website at https://lablabs.io/

---

![Terraform validation](https://github.com/lablabs/terraform-aws-cloudtrail/workflows/Terraform%20validation/badge.svg?branch=master)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-success?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)

## Description

A terraform module to create AWS CloudTrail resource.

## Related Projects

Check out other [terraform modules](https://github.com/orgs/lablabs/repositories?q=terraform-aws&type=public&language=&sort=).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.19 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloudtrail"></a> [cloudtrail](#module\_cloudtrail) | cloudposse/cloudtrail/aws | 0.20.0 |
| <a name="module_cloudtrail-s3-bucket"></a> [cloudtrail-s3-bucket](#module\_cloudtrail-s3-bucket) | cloudposse/s3-log-storage/aws | 1.0.0 |
| <a name="module_kms-key"></a> [kms-key](#module\_kms-key) | cloudposse/kms-key/aws | 0.12.1 |
| <a name="module_label"></a> [label](#module\_label) | cloudposse/label/null | 0.25.0 |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.trail_kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_trail_kms_account_ids"></a> [trail\_kms\_account\_ids](#input\_trail\_kms\_account\_ids) | Specifies all account ids where organization trail will resides | `list(any)` | n/a | yes |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | Additional attributes (e.g. `1`) | `list(string)` | `[]` | no |
| <a name="input_bucket_acl"></a> [bucket\_acl](#input\_bucket\_acl) | The canned ACL to apply. We recommend log-delivery-write for compatibility with AWS services | `string` | `"log-delivery-write"` | no |
| <a name="input_bucket_allow_ssl_requests_only"></a> [bucket\_allow\_ssl\_requests\_only](#input\_bucket\_allow\_ssl\_requests\_only) | Set to `true` to require requests to use Secure Socket Layer (HTTPS/SSL). This will explicitly deny access to HTTP requests | `bool` | `false` | no |
| <a name="input_bucket_enabled"></a> [bucket\_enabled](#input\_bucket\_enabled) | Set to `false` to prevent the module from creating s3 bucket | `bool` | `false` | no |
| <a name="input_bucket_force_destroy"></a> [bucket\_force\_destroy](#input\_bucket\_force\_destroy) | (Optional, Default:false ) A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable | `bool` | `false` | no |
| <a name="input_bucket_kms_master_key_arn"></a> [bucket\_kms\_master\_key\_arn](#input\_bucket\_kms\_master\_key\_arn) | The AWS KMS master key ARN used for the SSE-KMS encryption. This can only be used when you set the value of sse\_algorithm as aws:kms. The default aws/s3 AWS KMS master key is used if this element is absent while the sse\_algorithm is aws:kms | `string` | `""` | no |
| <a name="input_bucket_lifecycle_configuration_rules"></a> [bucket\_lifecycle\_configuration\_rules](#input\_bucket\_lifecycle\_configuration\_rules) | A list of S3 bucket v2 lifecycle rules | <pre>list(object({<br>    enabled = bool<br>    id      = string<br><br>    abort_incomplete_multipart_upload_days = number<br><br>    filter_and = any<br>    expiration = any<br>    transition = list(any)<br><br>    noncurrent_version_expiration = any<br>    noncurrent_version_transition = list(any)<br>  }))</pre> | `[]` | no |
| <a name="input_bucket_lifecycle_rule_enabled"></a> [bucket\_lifecycle\_rule\_enabled](#input\_bucket\_lifecycle\_rule\_enabled) | Enable lifecycle events on this bucket | `bool` | `false` | no |
| <a name="input_bucket_sse_algorithm"></a> [bucket\_sse\_algorithm](#input\_bucket\_sse\_algorithm) | The server-side encryption algorithm to use. Valid values are AES256 and aws:kms | `string` | `"AES256"` | no |
| <a name="input_bucket_versioning_enabled"></a> [bucket\_versioning\_enabled](#input\_bucket\_versioning\_enabled) | Enable object versioning, keeping multiple variants of an object in the same bucket | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT' | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Solution name, e.g. 'app' or 'jenkins' | `string` | `""` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp' | `string` | `""` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | Stage, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `map('BusinessUnit','XYZ')` | `map(string)` | `{}` | no |
| <a name="input_trail_bucket"></a> [trail\_bucket](#input\_trail\_bucket) | Set bucket name for the Organization trail, meaningful only if bucket\_enabled is set to false | `string` | `""` | no |
| <a name="input_trail_cloud_watch_logs_group_arn"></a> [trail\_cloud\_watch\_logs\_group\_arn](#input\_trail\_cloud\_watch\_logs\_group\_arn) | Specifies a log group name using an Amazon Resource Name (ARN), that represents the log group to which CloudTrail logs will be delivered | `string` | `""` | no |
| <a name="input_trail_cloud_watch_logs_role_arn"></a> [trail\_cloud\_watch\_logs\_role\_arn](#input\_trail\_cloud\_watch\_logs\_role\_arn) | Specifies the role for the CloudWatch Logs endpoint to assume to write to a user’s log group | `string` | `""` | no |
| <a name="input_trail_enable_log_file_validation"></a> [trail\_enable\_log\_file\_validation](#input\_trail\_enable\_log\_file\_validation) | Specifies whether log file integrity validation is enabled. Creates signed digest for validated contents of logs | `bool` | `false` | no |
| <a name="input_trail_enable_logging"></a> [trail\_enable\_logging](#input\_trail\_enable\_logging) | Enable logging for the trail | `bool` | `false` | no |
| <a name="input_trail_enabled"></a> [trail\_enabled](#input\_trail\_enabled) | Set to false to prevent the module from creating the Organization trail | `bool` | `true` | no |
| <a name="input_trail_include_global_service_events"></a> [trail\_include\_global\_service\_events](#input\_trail\_include\_global\_service\_events) | Specifies whether the trail is publishing events from global services such as IAM to the log files | `bool` | `false` | no |
| <a name="input_trail_is_multi_region_trail"></a> [trail\_is\_multi\_region\_trail](#input\_trail\_is\_multi\_region\_trail) | Specifies whether the trail is created in the current region or in all regions | `bool` | `false` | no |
| <a name="input_trail_is_organization_trail"></a> [trail\_is\_organization\_trail](#input\_trail\_is\_organization\_trail) | The trail is an AWS Organizations trail | `bool` | `false` | no |
| <a name="input_trail_kms_alias"></a> [trail\_kms\_alias](#input\_trail\_kms\_alias) | The display name of the alias. The name must start with the word `alias` followed by a forward slash, leave default for auto generated alias | `string` | `""` | no |
| <a name="input_trail_kms_customer_master_key_spec"></a> [trail\_kms\_customer\_master\_key\_spec](#input\_trail\_kms\_customer\_master\_key\_spec) | Specifies whether the key contains a symmetric key or an asymmetric key pair and the encryption algorithms or signing algorithms that the key supports. Valid values: `SYMMETRIC_DEFAULT`, `RSA_2048`, `RSA_3072`, `RSA_4096`, `ECC_NIST_P256`, `ECC_NIST_P384`, `ECC_NIST_P521`, or `ECC_SECG_P256K1`. | `string` | `"SYMMETRIC_DEFAULT"` | no |
| <a name="input_trail_kms_description"></a> [trail\_kms\_description](#input\_trail\_kms\_description) | The description of the key as viewed in AWS console | `string` | `"KMS key to encrypt the logs delivered by CloudTrail"` | no |
| <a name="input_trail_kms_enable_key_rotation"></a> [trail\_kms\_enable\_key\_rotation](#input\_trail\_kms\_enable\_key\_rotation) | Specifies whether key rotation is enabled | `bool` | `false` | no |
| <a name="input_trail_kms_enabled"></a> [trail\_kms\_enabled](#input\_trail\_kms\_enabled) | Set to false to prevent the module from automatic KMS key creation | `bool` | `false` | no |
| <a name="input_trail_kms_key_arn"></a> [trail\_kms\_key\_arn](#input\_trail\_kms\_key\_arn) | Specifies the KMS key ARN to use to encrypt the logs delivered by CloudTrail, meaningful only if trail\_kms\_enabled is set to false | `string` | `""` | no |
| <a name="input_trail_kms_key_usage"></a> [trail\_kms\_key\_usage](#input\_trail\_kms\_key\_usage) | Specifies the intended use of the key. Valid values: `ENCRYPT_DECRYPT` or `SIGN_VERIFY`. | `string` | `"ENCRYPT_DECRYPT"` | no |
| <a name="input_trail_kms_multi_region"></a> [trail\_kms\_multi\_region](#input\_trail\_kms\_multi\_region) | Indicates whether the KMS key is a multi-Region (true) or regional (false) key. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_arn"></a> [bucket\_arn](#output\_bucket\_arn) | CloudTrail bucket ARN |
| <a name="output_bucket_domain_name"></a> [bucket\_domain\_name](#output\_bucket\_domain\_name) | CloudTrail bucket FQDN |
| <a name="output_bucket_id"></a> [bucket\_id](#output\_bucket\_id) | CloudTrail bucket ID |
| <a name="output_kms_key_alias_arn"></a> [kms\_key\_alias\_arn](#output\_kms\_key\_alias\_arn) | CloudTrail KMS key alias ARN |
| <a name="output_kms_key_alias_name"></a> [kms\_key\_alias\_name](#output\_kms\_key\_alias\_name) | CloudTrail KMS key alias name |
| <a name="output_kms_key_arn"></a> [kms\_key\_arn](#output\_kms\_key\_arn) | CloudTrail KMS key ARN |
| <a name="output_kms_key_id"></a> [kms\_key\_id](#output\_kms\_key\_id) | CloudTrail KMS key ID |
| <a name="output_trail_arn"></a> [trail\_arn](#output\_trail\_arn) | CloudTrail ARN |
| <a name="output_trail_home_region"></a> [trail\_home\_region](#output\_trail\_home\_region) | CloudTrail region in which the trail was created |
| <a name="output_trail_id"></a> [trail\_id](#output\_trail\_id) | CloudTrail name |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Contributing and reporting issues

Feel free to create an issue in this repository if you have questions, suggestions or feature requests.

### Validation, linters and pull-requests

We want to provide high quality code and modules. For this reason we are using
several [pre-commit hooks](.pre-commit-config.yaml) and
[GitHub Actions workflow](.github/workflows/). A pull-request to the
master branch will trigger these validations and lints automatically. Please
check your code before you will create pull-requests. See
[pre-commit documentation](https://pre-commit.com/) and
[GitHub Actions documentation](https://docs.github.com/en/actions) for further
details.


## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

See [LICENSE](LICENSE) for full details.

    Licensed to the Apache Software Foundation (ASF) under one
    or more contributor license agreements.  See the NOTICE file
    distributed with this work for additional information
    regarding copyright ownership.  The ASF licenses this file
    to you under the Apache License, Version 2.0 (the
    "License"); you may not use this file except in compliance
    with the License.  You may obtain a copy of the License at

      https://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on an
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied.  See the License for the
    specific language governing permissions and limitations
    under the License.
