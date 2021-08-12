terraform {
  required_version = "0.12.19"

  backend "s3" {
    bucket  = "bootcamp-2021-tf-state"
    key     = "dns/us-east-1/terraform.tfstate"
    encrypt = true

    dynamodb_table = "bootcamp-2021-tf-lock-table"
    region         = "us-east-1"
  }
}

provider "aws" {
  region  = "us-east-1"
  version = "~> 2.0"
}

locals {
  aws_region  = "us-east-1"
  name_prefix = "bootcamp-2021"
  domain_name = "bootcamp2021.online"

  common_tags = {
    CreatedBy             = "terraform"
    MaintainerSlackHandle = "${local.name_prefix}"
  }
}