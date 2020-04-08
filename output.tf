output "bucket_domain_name" {
  value       = module.cloudtrail-s3-bucket.bucket_domain_name
  description = "Cloudtrail bucket FQDN"
}

output "bucket_id" {
  value       = module.cloudtrail-s3-bucket.bucket_id
  description = "Cloudtrail bucket ID"
}

output "bucket_arn" {
  value       = module.cloudtrail-s3-bucket.bucket_arn
  description = "Cloudtrail bucket ARN"
}

output "kms_key_arn" {
  value       = module.kms-key.key_arn
  description = "Cloudtrail KMS key ARN"
}

output "kms_key_id" {
  value       = module.kms-key.key_id
  description = "Cloudtrail KMS key ID"
}

output "kms_key_alias_name" {
  value       = module.kms-key.alias_name
  description = "Cloudtrail KMS key alias name"
}

output "kms_key_alias_arn" {
  value       = module.kms-key.alias_arn
  description = "Cloudtrail KMS key alias ARN"
}

output "trail_id" {
  value       = module.cloudtrail.cloudtrail_id
  description = "Cloudtrail name"
}

output "trail_arn" {
  value       = module.cloudtrail.cloudtrail_arn
  description = "Cloudtrail ARN"
}

output "trail_home_region" {
  value       = module.cloudtrail.cloudtrail_home_region
  description = "Cloudtrail region in which the trail was created"
}
