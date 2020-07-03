output "bucket_domain_name" {
  value       = module.cloudtrail-s3-bucket.bucket_domain_name
  description = "CloudTrail bucket FQDN"
}

output "bucket_id" {
  value       = module.cloudtrail-s3-bucket.bucket_id
  description = "CloudTrail bucket ID"
}

output "bucket_arn" {
  value       = module.cloudtrail-s3-bucket.bucket_arn
  description = "CloudTrail bucket ARN"
}

output "kms_key_arn" {
  value       = module.kms-key.key_arn
  description = "CloudTrail KMS key ARN"
}

output "kms_key_id" {
  value       = module.kms-key.key_id
  description = "CloudTrail KMS key ID"
}

output "kms_key_alias_name" {
  value       = module.kms-key.alias_name
  description = "CloudTrail KMS key alias name"
}

output "kms_key_alias_arn" {
  value       = module.kms-key.alias_arn
  description = "CloudTrail KMS key alias ARN"
}

output "trail_id" {
  value       = module.cloudtrail.cloudtrail_id
  description = "CloudTrail name"
}

output "trail_arn" {
  value       = module.cloudtrail.cloudtrail_arn
  description = "CloudTrail ARN"
}

output "trail_home_region" {
  value       = module.cloudtrail.cloudtrail_home_region
  description = "CloudTrail region in which the trail was created"
}
