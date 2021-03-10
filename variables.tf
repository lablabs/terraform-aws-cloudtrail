variable "namespace" {
  type        = string
  default     = ""
  description = "Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp'"
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT'"
}

variable "name" {
  type        = string
  default     = ""
  description = "Solution name, e.g. 'app' or 'jenkins'"
}

variable "attributes" {
  type        = list(string)
  default     = []
  description = "Additional attributes (e.g. `1`)"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. `map('BusinessUnit','XYZ')`"
}

variable "bucket_enabled" {
  type        = bool
  description = "Set to `false` to prevent the module from creating s3 bucket"
  default     = false
}

variable "bucket_force_destroy" {
  type        = bool
  description = "(Optional, Default:false ) A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable"
  default     = false
}

variable "bucket_acl" {
  type        = string
  description = "The canned ACL to apply. We recommend log-delivery-write for compatibility with AWS services"
  default     = "log-delivery-write"
}

variable "bucket_expiration_days" {
  description = "Number of days after which to expunge the objects"
  default     = 90
}

variable "bucket_lifecycle_rule_enabled" {
  type        = bool
  description = "Enable lifecycle events on this bucket"
  default     = false
}

variable "bucket_lifecycle_prefix" {
  type        = string
  description = "Prefix filter. Used to manage object lifecycle events"
  default     = ""
}

variable "bucket_lifecycle_tags" {
  type        = map(string)
  description = "Tags filter. Used to manage object lifecycle events"
  default     = {}
}

variable "bucket_standard_transition_days" {
  description = "Number of days to persist in the standard storage tier before moving to the infrequent access tier"
  default     = 30
}

variable "bucket_enable_glacier_transition" {
  type        = bool
  default     = false
  description = "Glacier transition might just increase your bill. Set to false to disable lifecycle transitions to AWS Glacier."
}

variable "bucket_glacier_transition_days" {
  description = "Number of days after which to move the data to the glacier storage tier"
  default     = 60
}

variable "bucket_sse_algorithm" {
  type        = string
  description = "The server-side encryption algorithm to use. Valid values are AES256 and aws:kms"
  default     = "AES256"
}

variable "bucket_kms_master_key_arn" {
  type        = string
  description = "The AWS KMS master key ARN used for the SSE-KMS encryption. This can only be used when you set the value of sse_algorithm as aws:kms. The default aws/s3 AWS KMS master key is used if this element is absent while the sse_algorithm is aws:kms"
  default     = ""
}

variable "trail_enabled" {
  type        = bool
  description = "Set to false to prevent the module from creating the Organization trail"
  default     = true
}

variable "trail_bucket" {
  type        = string
  description = "Set bucket name for the Organization trail, meaningful only if bucket_enabled is set to false"
  default     = ""
}

variable "trail_is_organization_trail" {
  type        = bool
  default     = false
  description = "The trail is an AWS Organizations trail"
}

variable "trail_is_multi_region_trail" {
  type        = bool
  default     = false
  description = "Specifies whether the trail is created in the current region or in all regions"
}

variable "trail_include_global_service_events" {
  type        = bool
  default     = false
  description = "Specifies whether the trail is publishing events from global services such as IAM to the log files"
}

variable "trail_enable_logging" {
  type        = bool
  default     = false
  description = "Enable logging for the trail"
}

variable "trail_enable_log_file_validation" {
  type        = bool
  default     = false
  description = "Specifies whether log file integrity validation is enabled. Creates signed digest for validated contents of logs"
}

variable "trail_cloud_watch_logs_role_arn" {
  type        = string
  description = "Specifies the role for the CloudWatch Logs endpoint to assume to write to a user’s log group"
  default     = ""
}

variable "trail_cloud_watch_logs_group_arn" {
  type        = string
  description = "Specifies a log group name using an Amazon Resource Name (ARN), that represents the log group to which CloudTrail logs will be delivered"
  default     = ""
}

variable "trail_kms_key_arn" {
  type        = string
  description = "Specifies the KMS key ARN to use to encrypt the logs delivered by CloudTrail, meaningful only if trail_kms_enabled is set to false"
  default     = ""
}

variable "trail_kms_enabled" {
  type        = bool
  default     = false
  description = "Set to false to prevent the module from automatic KMS key creation"
}

variable "trail_kms_account_ids" {
  type        = list(any)
  description = "Specifies all account ids where organization trail will resides"
}

variable "trail_kms_description" {
  type        = string
  default     = "KMS key to encrypt the logs delivered by CloudTrail"
  description = "The description of the key as viewed in AWS console"
}

variable "trail_kms_alias" {
  type        = string
  default     = ""
  description = "The display name of the alias. The name must start with the word `alias` followed by a forward slash, leave default for auto generated alias"
}

variable "trail_kms_enable_key_rotation" {
  type        = bool
  default     = false
  description = "Specifies whether key rotation is enabled"
}
