module "cloudtrail-s3-bucket" {
  source  = "cloudposse/s3-log-storage/aws"
  version = "1.4.2"

  context = module.label.context

  enabled                       = var.bucket_enabled
  force_destroy                 = var.bucket_force_destroy
  acl                           = var.bucket_acl
  source_policy_documents       = [try(data.aws_iam_policy_document.default[0].json, "")]
  sse_algorithm                 = var.bucket_sse_algorithm
  kms_master_key_arn            = var.bucket_kms_master_key_arn
  lifecycle_rule_enabled        = var.bucket_lifecycle_rule_enabled
  lifecycle_configuration_rules = var.bucket_lifecycle_configuration_rules
  allow_ssl_requests_only       = var.bucket_allow_ssl_requests_only
  versioning_enabled            = var.bucket_versioning_enabled
  object_lock_configuration = var.bucket_object_lock_configuration != null ? {
    mode  = var.bucket_object_lock_configuration.mode
    days  = var.bucket_object_lock_configuration.days
    years = var.bucket_object_lock_configuration.years
  } : null

  providers = {
    aws = aws.destination
  }
}

data "aws_iam_policy_document" "default" {
  count = var.bucket_enabled ? 1 : 0

  statement {
    sid = "AWSCloudTrailAclCheck"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions = [
      "s3:GetBucketAcl",
    ]

    resources = [
      "${local.arn_format}:s3:::${module.label.id}",
    ]
  }

  statement {
    sid = "AWSCloudTrailWrite"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com", "config.amazonaws.com"]
    }

    actions = [
      "s3:PutObject",
    ]

    resources = [
      "${local.arn_format}:s3:::${module.label.id}/*",
    ]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"

      values = [
        "bucket-owner-full-control",
      ]
    }
  }
}

data "aws_partition" "current" {}

locals {
  arn_format = "arn:${data.aws_partition.current.partition}"
}

resource "terraform_data" "bucket_object_lock_validation" {
  count = var.bucket_object_lock_configuration != null ? 1 : 0

  input = {
    versioning_enabled      = var.bucket_versioning_enabled
    compliance_mode_enabled = var.bucket_object_lock_compliance_mode_enabled
  }

  lifecycle {
    precondition {
      condition     = var.bucket_versioning_enabled
      error_message = "var.bucket_versioning_enabled must be true when var.bucket_object_lock_configuration is set."
    }

    precondition {
      condition     = var.bucket_object_lock_configuration.mode != "COMPLIANCE" || var.bucket_object_lock_compliance_mode_enabled
      error_message = "You are about to enable COMPLIANCE mode on the object lock, which cannot be removed. Confirm your decision by setting var.bucket_object_lock_compliance_mode_enabled to true."
    }
  }
}
