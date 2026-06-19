terraform {
  required_version = "~> 1.15.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }

    sops = {
      source  = "carlpett/sops"
      version = "~> 1.4"
    }
  }

  backend "s3" {
    bucket = "brad-tf-state"
    key    = "bootstrap/terraform.tfstate"
    region = "us-east-2"
  }
}
