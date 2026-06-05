terraform {
  required_version = ">= 1.7.0"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.2"
    }
  }

  # Choose ONE backend and uncomment it (see Step 5 of the setup guide)
  # Option A: Terraform Cloud
  # backend "cloud" {
  #   organization = "transparency-x"      # your TFC org
  #   workspaces {
  #     name = "sonic-harm-infra"
  #   }
  # }

  # Option B: S3 + DynamoDB
  # backend "s3" {
  #   bucket         = "sonic-harm-tf-state"
  #   key            = "infra/terraform.tfstate"
  #   region         = "eu-west-1"
  #   dynamodb_table = "terraform-lock"
  # }
}
