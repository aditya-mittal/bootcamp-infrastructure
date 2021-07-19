terraform {
  required_version = "0.12.19"

  backend "s3" {
    bucket  = "ee-pune-bootcamp-2021-tf-state"
    key     = "vpc/us-east-1/terraform.tfstate"
    encrypt = true

    region         = "us-east-1"
    dynamodb_table = "ee-pune-bootcamp-2021-terraform-lock-table"
  }
}

provider "aws" {
  region  = "us-east-1"
  version = "~> 2.0"
}

locals {
  name_prefix = "bootcamp-2021-ee-pune"
  common_tags = {
    CreatedBy             = "terraform"
    MaintainerSlackHandle = "${local.name_prefix}"
  }
}