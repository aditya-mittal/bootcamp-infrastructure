terraform {
  required_version = "0.12.19"

  backend "s3" {
    bucket  = "REPLACE-USERNAME-ee-pune-bootcamp-2021-tf-state"
    key     = "REPLACE-USERNAME-alb/us-east-1/terraform.tfstate"
    encrypt = true

    dynamodb_table = "REPLACE-USERNAME-ee-pune-bootcamp-2021-terraform-lock-table"
    region         = "us-east-1"
  }
}

provider "aws" {
  region  = "us-east-1"
  version = "~> 2.0"
}

locals {
  aws_region  = "us-east-1"
  name_prefix = "REPLACE-USERNAME-bootcamp-2021-ee-pune"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  common_tags = {
    CreatedBy             = "terraform"
    MaintainerSlackHandle = "${local.name_prefix}"
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "REPLACE-USERNAME-ee-pune-bootcamp-2021-tf-state"
    key    = "REPLACE-USERNAME-vpc/us-east-1/terraform.tfstate"
    region = "us-east-1"
  }
}

data "aws_subnet_ids" "public_subnets" {
  vpc_id = local.vpc_id

  tags = {
    Type = "public"
  }
}