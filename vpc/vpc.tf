resource "aws_vpc" "main" {
  cidr_block           = "FILL_ME"
  enable_dns_hostnames = true

  tags = merge(
    map(
      "Name", "${local.name_prefix}-vpc"
    ),
    local.common_tags
  )
}