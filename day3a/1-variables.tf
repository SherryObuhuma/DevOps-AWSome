variable "tf_region" {
  type        = string
  default     = "eu-north-1"
  description = "AWS Region"
}


variable "tf_access_key" {
  type    = string
  default = ""
}

variable "tf_secrete_key" {
  type    = string
  default = ""
}

variable "tf_profile" {
  type    = string
  default = "default"
}

variable "tf_vpc_cidr_block" {
  type    = string
  default = "11.0.0.0/16"
}

variable "tf_tags" {
  type = map(string)
  default = {
    "terraform"  = "true"
    "kubernetes" = "eks-cluster"
  }
}


variable "tf_eks_version" {
  type        = string
  default     = "1.31"
  description = "EKS version"
}

variable "tf_cluster_name" {
  type        = string
  default     = "test_eks_cluster"
  description = "EKS Name"
}