terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.4.0"
    }
  }
}

provider "aws" {
  region     = var.dev_region
  access_key = var.dev_access_key
  secret_key = var.dev_secret_key
  profile    = var.dev_user_profile
}