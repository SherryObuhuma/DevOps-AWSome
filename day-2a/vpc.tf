resource "aws_vpc" "tf_vpc" {
  cidr_block       = var.tf_vpc_cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "tf_vpc"
  }
}