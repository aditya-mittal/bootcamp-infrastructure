terraform {
  required_version = "0.12.19"

  backend "s3" {
    bucket  = "ee-pune-bootcamp-2021-tf-state"
    key     = "jenkins/us-east-1/terraform.tfstate"
    encrypt = true

    dynamodb_table = "ee-pune-bootcamp-2021-terraform-lock-table"
    region         = "us-east-1"
  }
}

provider "aws" {
  region  = "us-east-1"
  version = "~> 2.0"
}

locals {
  aws_region  = "us-east-1"
  name_prefix = "bootcamp-2021-ee-pune"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id
  alb_arn     = data.terraform_remote_state.alb.outputs.alb_arn
  alb_sg_id   = data.terraform_remote_state.alb.outputs.alb_sg_id

  common_tags = {
    CreatedBy             = "terraform"
    MaintainerSlackHandle = "${local.name_prefix}"
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "ee-pune-bootcamp-2021-tf-state"
    key    = "vpc/us-east-1/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "alb" {
  backend = "s3"

  config = {
    bucket = "ee-pune-bootcamp-2021-tf-state"
    key    = "alb/us-east-1/terraform.tfstate"
    region = "us-east-1"
  }
}

data "aws_subnet_ids" "private_subnet_ids" {
  vpc_id = local.vpc_id

  tags = {
    Type = "private"
  }
}