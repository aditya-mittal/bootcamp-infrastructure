terraform {
  required_version = "0.12.19"

  backend "s3" {
    bucket  = "bootcamp-2021-tf-state"
    key     = "ecr/us-east-1/terraform.tfstate"
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
  name_prefix = "bootcamp-2021"
  common_tags = {
    CreatedBy             = "terraform"
    MaintainerSlackHandle = "${local.name_prefix}"
  }
}

resource "aws_ecr_repository" "jenkins" {
  name = "${local.name_prefix}-ecr/jenkins"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = merge(
    map(
      "Name", "${local.name_prefix}-ecr/jenkins"
    ),
    local.common_tags
  )
}