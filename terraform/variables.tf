# AWS Region
variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}

# Environment
variable "environment" {
  description = "Environment name (dev, prod)"
  type        = string
  default     = "dev"
  
  validation {
    condition     = contains(["dev","prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

# Project Name
variable "project_name" {
  description = "Project name to be used for resource naming"
  type        = string
  default     = "terraform-demo"
  
  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.project_name))
    error_message = "Project name must contain only lowercase letters, numbers, and hyphens."
  }
}
