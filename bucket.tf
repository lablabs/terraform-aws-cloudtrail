module "cloudtrail-s3-bucket" {
  source  = "cloudposse/cloudtrail-s3-bucket/aws"
  version = "0.7.0"

  namespace   = module.label.namespace
  environment = module.label.environment
  name        = module.label.name
  attributes  = module.label.attributes
  tags        = module.label.tags

  enabled                   = var.bucket_enabled
  force_destroy             = var.bucket_force_destroy
  acl                       = var.bucket_acl
  expiration_days           = var.bucket_expiration_days
  sse_algorithm             = var.bucket_sse_algorithm
  kms_master_key_arn        = var.bucket_kms_master_key_arn
  lifecycle_rule_enabled    = var.bucket_lifecycle_rule_enabled
  lifecycle_prefix          = var.bucket_lifecycle_prefix
  lifecycle_tags            = var.bucket_lifecycle_tags
  standard_transition_days  = var.bucket_standard_transition_days
  enable_glacier_transition = var.bucket_enable_glacier_transition
  glacier_transition_days   = var.bucket_glacier_transition_days

  providers = {
    aws = aws.destination
  }
}
