# Local variables
locals {
  # Generate unique suffix for bucket names using timestamp-based approach
  # In production, consider using a more permanent unique identifier
  name_prefix = "${var.project_name}-${var.environment}"
  
  # Bucket names - must be globally unique in AWS
  bucket_names = {
    data    = "${local.name_prefix}-data-${data.aws_caller_identity.current.account_id}"
    logs    = "${local.name_prefix}-logs-${data.aws_caller_identity.current.account_id}"
    backups = "${local.name_prefix}-backups-${data.aws_caller_identity.current.account_id}"
  }
  
  # Common tags to be applied to all resources
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Repository  = "sasi-terraform-demo"
  }
  
  # Bucket-specific configurations
  bucket_configs = {
    data    = { versioning = true, encryption = true }
    logs    = { versioning = false, encryption = true }
    backups = { versioning = true, encryption = true }
  }
}

# Data source to get current AWS account ID
data "aws_caller_identity" "current" {}
