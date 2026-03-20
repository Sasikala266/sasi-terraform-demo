# Terraform configuration
terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.4"
    }
  }
  
  backend "s3" {
    bucket = "terraform-tfstate-bucket-aiuscase"
    key    = "sasi-terraform-demo/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.aws_region
  
  default_tags {
    tags = {
      Project     = var.project_name
      ManagedBy   = "Terraform"
      Environment = var.environment
    }
  }
}

# Data source for current AWS account
data "aws_caller_identity" "current" {}

data "aws_region" "current" {}



# S3 Bucket 1: Data Bucket
resource "aws_s3_bucket" "data" {
  bucket = local.bucket_names.data

  tags = merge(
    local.common_tags,
    {
      Name        = local.bucket_names.data
      Purpose     = "Data storage"
      Description = "Bucket for storing application data"
    }
  )
}

resource "aws_s3_bucket_versioning" "data" {
  bucket = aws_s3_bucket.data.id

  versioning_configuration {
    status = local.bucket_configs.data.versioning ? "Enabled" : "Disabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "data" {
  bucket = aws_s3_bucket.data.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "data" {
  bucket = aws_s3_bucket.data.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# S3 Bucket 2: Logs Bucket
resource "aws_s3_bucket" "logs" {
  bucket = local.bucket_names.logs

  tags = merge(
    local.common_tags,
    {
      Name        = local.bucket_names.logs
      Purpose     = "Logs storage"
      Description = "Bucket for storing application and access logs"
    }
  )
}

resource "aws_s3_bucket_versioning" "logs" {
  bucket = aws_s3_bucket.logs.id

  versioning_configuration {
    status = local.bucket_configs.logs.versioning ? "Enabled" : "Disabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "logs" {
  bucket = aws_s3_bucket.logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "logs" {
  bucket = aws_s3_bucket.logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# S3 Bucket 3: Backups Bucket
resource "aws_s3_bucket" "backups" {
  bucket = local.bucket_names.backups

  tags = merge(
    local.common_tags,
    {
      Name        = local.bucket_names.backups
      Purpose     = "Backups storage"
      Description = "Bucket for storing backup files and archives"
    }
  )
}

resource "aws_s3_bucket_versioning" "backups" {
  bucket = aws_s3_bucket.backups.id

  versioning_configuration {
    status = local.bucket_configs.backups.versioning ? "Enabled" : "Disabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "backups" {
  bucket = aws_s3_bucket.backups.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "backups" {
  bucket = aws_s3_bucket.backups.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

