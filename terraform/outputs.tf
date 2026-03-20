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
