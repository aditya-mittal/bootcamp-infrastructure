terraform {
  required_version = "0.12.19"

  backend "s3" {
    bucket  = "REPLACE-USERNAME-bootcamp-2021-tf-state"
    key     = "alb/us-east-1/terraform.tfstate"
    encrypt = true

    dynamodb_table = "REPLACE-USERNAME-bootcamp-2021-tf-lock-table"
    region         = "us-east-1"
  }
}

provider "aws" {
  region  = "us-east-1"
  version = "~> 2.0"
}

locals {
  aws_region   = "us-east-1"
  name_prefix  = "REPLACE-USERNAME-bootcamp-2021"
  vpc_id       = data.terraform_remote_state.vpc.outputs.vpc_id
  ssl_cert_arn = "arn:aws:acm:us-east-1:038062473746:certificate/173d9264-4314-460a-a32c-8c9d0203f200"

  common_tags = {
    CreatedBy             = "terraform"
    MaintainerSlackHandle = "${local.name_prefix}"
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "REPLACE-USERNAME-bootcamp-2021-tf-state"
    key    = "vpc/us-east-1/terraform.tfstate"
    region = "us-east-1"
  }
}

data "aws_subnet_ids" "public_subnets" {
  vpc_id = local.vpc_id

  tags = {
    Type = "public"
  }
}