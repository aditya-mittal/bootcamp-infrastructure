resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    map(
      "Name", "${local.name_prefix}-igw"
    ),
    local.common_tags
  )
}
