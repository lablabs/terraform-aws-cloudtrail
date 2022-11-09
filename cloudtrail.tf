module "cloudtrail" {
  source  = "cloudposse/cloudtrail/aws"
  version = "0.22.0"

  namespace   = module.label.namespace
  environment = module.label.environment
  name        = module.label.name
  attributes  = module.label.attributes
  tags        = module.label.tags

  enabled                       = var.trail_enabled
  s3_bucket_name                = var.bucket_enabled ? module.cloudtrail-s3-bucket.bucket_id : var.trail_bucket
  kms_key_arn                   = var.trail_kms_enabled ? module.kms-key.key_arn : var.trail_kms_key_arn
  is_organization_trail         = var.trail_is_organization_trail
  is_multi_region_trail         = var.trail_is_multi_region_trail
  include_global_service_events = var.trail_include_global_service_events
  enable_logging                = var.trail_enable_logging
  enable_log_file_validation    = var.trail_enable_log_file_validation
  cloud_watch_logs_role_arn     = var.trail_cloud_watch_logs_role_arn
  cloud_watch_logs_group_arn    = var.trail_cloud_watch_logs_group_arn
}
