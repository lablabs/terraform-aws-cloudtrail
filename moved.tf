moved {
  from = aws_s3_bucket_object_lock_configuration.default
  to   = module.cloudtrail-s3-bucket.module.aws_s3_bucket.aws_s3_bucket_object_lock_configuration.default
}
