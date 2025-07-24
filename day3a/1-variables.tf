variable "dev_region" {
  type        = string
  default     = "eu-west-3"
  description = "Development cluster region"
}

variable "dev_access_key" {
  type        = string
  default     = ""
  description = "Development cluster user access key"
}

variable "dev_secret_key" {
  type        = string
  default     = ""
  description = "Development cluster user secret key."
}
variable "dev_user_profile" {
  type        = string
  default     = ""
  description = "Development cluster user profile"
}

variable "dev_vpc_cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "VPC cidr block"
}


