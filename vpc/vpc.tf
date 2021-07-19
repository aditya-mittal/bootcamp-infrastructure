resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = merge(
    map(
      "Name", "${local.name_prefix}-vpc"
    ),
    local.common_tags
  )
}