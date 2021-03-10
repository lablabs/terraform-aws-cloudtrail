# AWS CloudTrail Terraform module

[![Labyrinth Labs logo](ll-logo.png)](https://www.lablabs.io)

We help companies build, run, deploy and scale software and infrastructure by embracing the right technologies and principles. Check out our website at https://lablabs.io/

---

![Terraform validation](https://github.com/lablabs/terraform-aws-cloudtrail/workflows/Terraform%20validation/badge.svg?branch=master)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-success?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)

## Description

A terraform module to create AWS CloudTrail resource.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| aws | >= 2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| cloudtrail | cloudposse/cloudtrail/aws | 0.20.0 |
| cloudtrail-s3-bucket | cloudposse/cloudtrail-s3-bucket/aws | 0.17.2 |
| kms-key | cloudposse/kms-key/aws | 0.9.1 |
| label | cloudposse/label/null | 0.24.1 |

## Resources

| Name |
|------|
| [aws_caller_identity](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) |
| [aws_iam_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| trail\_kms\_account\_ids | Specifies all account ids where organization trail will resides | `list(any)` | n/a | yes |
| attributes | Additional attributes (e.g. `1`) | `list(string)` | `[]` | no |
| bucket\_acl | The canned ACL to apply. We recommend log-delivery-write for compatibility with AWS services | `string` | `"log-delivery-write"` | no |
| bucket\_enable\_glacier\_transition | Glacier transition might just increase your bill. Set to false to disable lifecycle transitions to AWS Glacier. | `bool` | `false` | no |
| bucket\_enabled | Set to `false` to prevent the module from creating s3 bucket | `bool` | `false` | no |
| bucket\_expiration\_days | Number of days after which to expunge the objects | `number` | `90` | no |
| bucket\_force\_destroy | (Optional, Default:false ) A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable | `bool` | `false` | no |
| bucket\_glacier\_transition\_days | Number of days after which to move the data to the glacier storage tier | `number` | `60` | no |
| bucket\_kms\_master\_key\_arn | The AWS KMS master key ARN used for the SSE-KMS encryption. This can only be used when you set the value of sse\_algorithm as aws:kms. The default aws/s3 AWS KMS master key is used if this element is absent while the sse\_algorithm is aws:kms | `string` | `""` | no |
| bucket\_lifecycle\_prefix | Prefix filter. Used to manage object lifecycle events | `string` | `""` | no |
| bucket\_lifecycle\_rule\_enabled | Enable lifecycle events on this bucket | `bool` | `false` | no |
| bucket\_lifecycle\_tags | Tags filter. Used to manage object lifecycle events | `map(string)` | `{}` | no |
| bucket\_sse\_algorithm | The server-side encryption algorithm to use. Valid values are AES256 and aws:kms | `string` | `"AES256"` | no |
| bucket\_standard\_transition\_days | Number of days to persist in the standard storage tier before moving to the infrequent access tier | `number` | `30` | no |
| environment | Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT' | `string` | `""` | no |
| name | Solution name, e.g. 'app' or 'jenkins' | `string` | `""` | no |
| namespace | Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp' | `string` | `""` | no |
| tags | Additional tags (e.g. `map('BusinessUnit','XYZ')` | `map(string)` | `{}` | no |
| trail\_bucket | Set bucket name for the Organization trail, meaningful only if bucket\_enabled is set to false | `string` | `""` | no |
| trail\_cloud\_watch\_logs\_group\_arn | Specifies a log group name using an Amazon Resource Name (ARN), that represents the log group to which CloudTrail logs will be delivered | `string` | `""` | no |
| trail\_cloud\_watch\_logs\_role\_arn | Specifies the role for the CloudWatch Logs endpoint to assume to write to a user’s log group | `string` | `""` | no |
| trail\_enable\_log\_file\_validation | Specifies whether log file integrity validation is enabled. Creates signed digest for validated contents of logs | `bool` | `false` | no |
| trail\_enable\_logging | Enable logging for the trail | `bool` | `false` | no |
| trail\_enabled | Set to false to prevent the module from creating the Organization trail | `bool` | `true` | no |
| trail\_include\_global\_service\_events | Specifies whether the trail is publishing events from global services such as IAM to the log files | `bool` | `false` | no |
| trail\_is\_multi\_region\_trail | Specifies whether the trail is created in the current region or in all regions | `bool` | `false` | no |
| trail\_is\_organization\_trail | The trail is an AWS Organizations trail | `bool` | `false` | no |
| trail\_kms\_alias | The display name of the alias. The name must start with the word `alias` followed by a forward slash, leave default for auto generated alias | `string` | `""` | no |
| trail\_kms\_description | The description of the key as viewed in AWS console | `string` | `"KMS key to encrypt the logs delivered by CloudTrail"` | no |
| trail\_kms\_enable\_key\_rotation | Specifies whether key rotation is enabled | `bool` | `false` | no |
| trail\_kms\_enabled | Set to false to prevent the module from automatic KMS key creation | `bool` | `false` | no |
| trail\_kms\_key\_arn | Specifies the KMS key ARN to use to encrypt the logs delivered by CloudTrail, meaningful only if trail\_kms\_enabled is set to false | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket\_arn | CloudTrail bucket ARN |
| bucket\_domain\_name | CloudTrail bucket FQDN |
| bucket\_id | CloudTrail bucket ID |
| kms\_key\_alias\_arn | CloudTrail KMS key alias ARN |
| kms\_key\_alias\_name | CloudTrail KMS key alias name |
| kms\_key\_arn | CloudTrail KMS key ARN |
| kms\_key\_id | CloudTrail KMS key ID |
| trail\_arn | CloudTrail ARN |
| trail\_home\_region | CloudTrail region in which the trail was created |
| trail\_id | CloudTrail name |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Contributing and reporting issues

Feel free to create an issue in this repository if you have questions, suggestions or feature requests.

### Validation, linters and pull-requests

We want to provide high quality code and modules. For this reason we are using
several [pre-commit hooks](.pre-commit-config.yaml) and
[GitHub Actions workflow](.github/workflows/main.yml). A pull-request to the
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
