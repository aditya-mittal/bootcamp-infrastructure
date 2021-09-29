resource "aws_eip" "nat_eip_us_east_1a" {
  vpc = true

  tags = merge(
    map(
      "Name", "${local.name_prefix}-nat-us-east-1a"
    ),
    local.common_tags
  )

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "nat_gw_us_east_1a" {
  allocation_id = aws_eip.nat_eip_us_east_1a.id
  subnet_id     = aws_subnet.public_us_east_1a.id

  tags = merge(
    map(
      "Name", "${local.name_prefix}-nat-gw-us-east-1a"
    ),
    local.common_tags
  )

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_eip" "nat_eip_us_east_1b" {
  vpc = true

  tags = merge(
    map(
      "Name", "${local.name_prefix}-nat-us-east-1b"
    ),
    local.common_tags
  )

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "nat_gw_us_east_1b" {
  allocation_id = aws_eip.nat_eip_us_east_1b.id
  subnet_id     = aws_subnet.public_us_east_1b.id

  tags = merge(
    map(
      "Name", "${local.name_prefix}-nat-gw-us-east-1b"
    ),
    local.common_tags
  )

  depends_on = [aws_internet_gateway.igw]
}