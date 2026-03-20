# Data Bucket Outputs
output "data_bucket_id" {
  description = "The ID (name) of the data bucket"
  value       = aws_s3_bucket.data.id
}

output "data_bucket_arn" {
  description = "The ARN of the data bucket"
  value       = aws_s3_bucket.data.arn
}

output "data_bucket_region" {
  description = "The region of the data bucket"
  value       = aws_s3_bucket.data.region
}

# Logs Bucket Outputs
output "logs_bucket_id" {
  description = "The ID (name) of the logs bucket"
  value       = aws_s3_bucket.logs.id
}

output "logs_bucket_arn" {
  description = "The ARN of the logs bucket"
  value       = aws_s3_bucket.logs.arn
}

output "logs_bucket_region" {
  description = "The region of the logs bucket"
  value       = aws_s3_bucket.logs.region
}

# Backups Bucket Outputs
output "backups_bucket_id" {
  description = "The ID (name) of the backups bucket"
  value       = aws_s3_bucket.backups.id
}

output "backups_bucket_arn" {
  description = "The ARN of the backups bucket"
  value       = aws_s3_bucket.backups.arn
}

output "backups_bucket_region" {
  description = "The region of the backups bucket"
  value       = aws_s3_bucket.backups.region
}

# Summary Output
output "buckets_summary" {
  description = "Summary of all created S3 buckets"
  value = {
    data_bucket = {
      id              = aws_s3_bucket.data.id
      arn             = aws_s3_bucket.data.arn
      versioning      = local.bucket_configs.data.versioning
      encryption      = local.bucket_configs.data.encryption
    }
    logs_bucket = {
      id              = aws_s3_bucket.logs.id
      arn             = aws_s3_bucket.logs.arn
      versioning      = local.bucket_configs.logs.versioning
      encryption      = local.bucket_configs.logs.encryption
    }
    backups_bucket = {
      id              = aws_s3_bucket.backups.id
      arn             = aws_s3_bucket.backups.arn
      versioning      = local.bucket_configs.backups.versioning
      encryption      = local.bucket_configs.backups.encryption
    }
  }
}

# Deployment Information
output "deployment_info" {
  description = "Information about the deployment"
  value = {
    environment   = var.environment
    project_name  = var.project_name
    region        = var.aws_region
    account_id    = data.aws_caller_identity.current.account_id
  }
}
