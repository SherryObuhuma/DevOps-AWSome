/*
Create a vpc
create subnet inside vpc
Internet gateway associated with vpc
Route table inside vpc with a route that directs internet-bound traffic to the internet gateway
Route table association with our subnet to make it a public subnet
security group inside vpc
key pair used for ssh access
ec2 instance inside our public subnet with an associated security group and a genearated key pair
*/

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.4.0"
    }
  }
}

provider "aws" {
  region     = var.tf_region
  access_key = var.tf_access_key
  secret_key = var.tf_secret_key
}