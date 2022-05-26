module "cloudtrail-s3-bucket" {
  source  = "cloudposse/s3-log-storage/aws"
  version = "0.28.0"

  context = module.label.context

  enabled                   = var.bucket_enabled
  force_destroy             = var.bucket_force_destroy
  acl                       = var.bucket_acl
  policy                    = join("", data.aws_iam_policy_document.default.*.json)
  expiration_days           = var.bucket_expiration_days
  sse_algorithm             = var.bucket_sse_algorithm
  kms_master_key_arn        = var.bucket_kms_master_key_arn
  lifecycle_rule_enabled    = var.bucket_lifecycle_rule_enabled
  lifecycle_prefix          = var.bucket_lifecycle_prefix
  lifecycle_tags            = var.bucket_lifecycle_tags
  standard_transition_days  = var.bucket_standard_transition_days
  enable_glacier_transition = var.bucket_enable_glacier_transition
  glacier_transition_days   = var.bucket_glacier_transition_days
  allow_ssl_requests_only   = var.bucket_allow_ssl_requests_only
  versioning_enabled        = var.bucket_versioning_enabled

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
