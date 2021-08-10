terraform {
  required_version = "0.12.19"

  backend "s3" {
    bucket  = "ee-pune-bootcamp-2021-tf-state"
    key     = "nginx-ecs-service/us-east-1/terraform.tfstate"
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
  aws_region       = "us-east-1"
  name_prefix      = "bootcamp-2021-ee-pune"
  vpc_id           = data.terraform_remote_state.vpc.outputs.vpc_id
  alb_arn          = data.terraform_remote_state.alb.outputs.alb_arn
  cluster_name     = "${local.name_prefix}-cluster"
  service_name     = "nginx"
  container_port   = 80
  container_image  = "nginx:latest"
  container_cpu    = 10
  container_memory = 50
  desired_count    = 1
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