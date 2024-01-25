locals {
  trail_kms_alias = var.trail_kms_alias == "" ? "alias/${module.label.id}" : var.trail_kms_alias
}

data "aws_caller_identity" "kms" {
  provider = aws.destination
}

data "aws_iam_policy_document" "trail_kms" {
  #checkov:skip=CKV_AWS_1
  #checkov:skip=CKV_AWS_49
  #checkov:skip=CKV_AWS_107
  #checkov:skip=CKV_AWS_108
  #checkov:skip=CKV_AWS_109
  #checkov:skip=CKV_AWS_110
  #checkov:skip=CKV_AWS_111
  #checkov:skip=CKV_AWS_274
  #checkov:skip=CKV_AWS_356
  count = var.trail_enabled && var.trail_kms_enabled ? 1 : 0

  statement {
    sid     = "AWSCloudTrailKMSAllowEncrypt"
    effect  = "Allow"
    actions = ["kms:GenerateDataKey*"]

    resources = ["*"]

    principals {
      identifiers = ["cloudtrail.amazonaws.com"]
      type        = "Service"
    }

    dynamic "condition" {
      for_each = length(var.trail_kms_account_ids) > 0 ? [1] : []

      content {
        test     = "StringLike"
        variable = "kms:EncryptionContext:aws:cloudtrail:arn"
        values = formatlist(
          "arn:aws:cloudtrail:*:%s:trail/*",
          var.trail_kms_account_ids
        )
      }
    }
  }

  statement {
    sid       = "AWSCloudTrailKMSAllowAllForOwnerAccount"
    effect    = "Allow"
    actions   = ["kms:*"]
    resources = ["*"]

    principals {
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.kms.account_id}:root"]
      type        = "AWS"
    }
  }

  provider = aws.destination
}


module "kms-key" {
  source  = "cloudposse/kms-key/aws"
  version = "0.12.1"

  namespace   = module.label.namespace
  environment = module.label.environment
  name        = module.label.name
  attributes  = module.label.attributes
  tags        = module.label.tags

  enabled     = var.trail_enabled && var.trail_kms_enabled ? true : false
  description = var.trail_kms_description
  alias       = local.trail_kms_alias
  policy      = join("", data.aws_iam_policy_document.trail_kms.*.json)

  enable_key_rotation      = var.trail_kms_enable_key_rotation
  key_usage                = var.trail_kms_key_usage
  customer_master_key_spec = var.trail_kms_customer_master_key_spec
  multi_region             = var.trail_kms_multi_region

  providers = {
    aws = aws.destination
  }
}
