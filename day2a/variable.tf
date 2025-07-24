variable "tf_access_key" {
  default = "AKIAVIOZFNMHOWZFV5E7"
}

variable "tf_secret_key" {
  default = "DjQnCCO4V211b8VY5rcmwTbs5zBz+vA4m6+fCyAK"
}

variable "tf_region" {
  default = "eu-central-1"
}

variable "tf_vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "tf_public_subnet_cidr_block" {
  default = "10.0.1.0/24"
}

variable "tf_private_subnet_cidr_block" {
  default = "10.0.2.0/24"
}

variable "tf_vpc_cidr_block_rules" {
  default = "0.0.0.0/0"
}

variable "tf_ec2_ami" {
  default = "ami-02003f9f0fde924ea"
}

variable "tf_ec2_key" {
  default = "test-key-pair"
}

variable "tf_user_profile" {
  default = "terraform-test"
}