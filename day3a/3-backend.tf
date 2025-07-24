
terraform {
  backend "s3" {
    bucket  = "dev-s3-bucket-test-eks"
    key     = "terraform.tfstate"
    region  = "eu-west-3"
    profile = "terraform-test"
  }
}
