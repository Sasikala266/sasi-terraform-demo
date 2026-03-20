# sasi-terraform-demo
A demonstration project for deploying AWS S3 buckets using Terraform and GitHub Actions.

## Overview

This project creates three S3 buckets in AWS using Terraform:
- **Data Bucket**: For storing application data with versioning enabled
- **Logs Bucket**: For storing application and access logs
- **Backups Bucket**: For storing backup files with lifecycle policies

## Architecture

The Terraform configuration is organized into separate files for maintainability:
- `main.tf`: Provider and Terraform configuration
- `variables.tf`: Input variable declarations
- `locals.tf`: Local variables and computed values
- `resources.tf`: S3 bucket resource definitions
- `outputs.tf`: Output values for created resources

## Prerequisites

1. **AWS Account**: You need an AWS account with appropriate permissions
2. **GitHub Secrets**: Configure the following secrets in your GitHub repository:
   - `AWS_ACCESS_KEY_ID`: Your AWS access key ID
   - `AWS_SECRET_ACCESS_KEY`: Your AWS secret access key
   - `AWS_REGION` (optional): AWS region to deploy to (defaults to us-east-1)

### Setting up GitHub Secrets

1. Go to your GitHub repository
2. Navigate to Settings > Secrets and variables > Actions
3. Click "New repository secret"
4. Add the required secrets:
   - Name: `AWS_ACCESS_KEY_ID`, Value: `<your-aws-access-key-id>`
   - Name: `AWS_SECRET_ACCESS_KEY`, Value: `<your-aws-secret-access-key>`

**Security Note**: Never commit AWS credentials to your repository. Always use GitHub Secrets or other secure credential management solutions.

## Features

### Security Best Practices
- **Server-side encryption** enabled on all buckets (AES256)
- **Public access blocked** on all buckets
- **Versioning** enabled for data and backup buckets
- **Lifecycle policies** for backup bucket to optimize costs

### Bucket Configurations

**Data Bucket**:
- Versioning: Enabled
- Encryption: AES256
- Purpose: Application data storage

**Logs Bucket**:
- Versioning: Disabled
- Encryption: AES256
- Purpose: Application and access logs

**Backups Bucket**:
- Versioning: Enabled
- Encryption: AES256
- Lifecycle: 
  - Transition to Glacier after 30 days
  - Transition to Deep Archive after 90 days
  - Delete after 365 days

## Local Development

### Prerequisites
- Terraform >= 1.6.0
- AWS CLI configured with appropriate credentials

### Commands

```bash
# Navigate to terraform directory
cd terraform

# Initialize Terraform
terraform init

# Create terraform.tfvars (optional)
cat > terraform.tfvars <<EOF
aws_region   = "us-east-1"
environment  = "dev"
project_name = "terraform-demo"
EOF

# Validate configuration
terraform validate

# Plan deployment
terraform plan

# Apply changes
terraform apply

# Destroy resources
terraform destroy
```

## GitHub Actions Deployment

The repository includes a GitHub Actions workflow (`.github/workflows/deploy.yml`) that is currently commented out for safety. To enable automated deployments:

1. Uncomment the workflow file
2. Ensure GitHub secrets are configured
3. Push to the `main` branch or manually trigger the workflow

## Outputs

After deployment, Terraform outputs the following information:
- Bucket IDs, ARNs, and regions for all three buckets
- Summary of bucket configurations
- Deployment information (environment, project name, account ID)
