terraform {
  required_providers {
    local = {
      source = "hashicorp/local"
      version = "2.5.3"
    }
    # aws = {
    #   source = "hashicorp/aws"
    #   version = "6.4.0"
    # }
  }
}

provider "local" {
  # Configuration options
}

# provider "aws" {
#   region = ""
#   access_key = ""
#   secret_key = ""
# }