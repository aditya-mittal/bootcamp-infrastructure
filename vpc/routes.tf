resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(
    map(
      "Name", "${local.name_prefix}-public-route-table"
    ),
    local.common_tags
  )
}

resource "aws_route_table" "private_us_east_1a" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_us_east_1a.id
  }

  tags = merge(
    map(
      "Name", "${local.name_prefix}-private-route-table-us-east-1a"
    ),
    local.common_tags
  )
}

resource "aws_route_table" "private_us_east_1b" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_us_east_1b.id
  }

  tags = merge(
    map(
      "Name", "${local.name_prefix}-private-route-table-us-east-1b"
    ),
    local.common_tags
  )
}

resource "aws_route_table" "private_us_east_1c" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_us_east_1c.id
  }

  tags = merge(
    map(
      "Name", "${local.name_prefix}-private-route-table-us-east-1c"
    ),
    local.common_tags
  )
}

resource "aws_route_table_association" "public_us_east_1a" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public_us_east_1a.id
}

resource "aws_route_table_association" "public_us_east_1b" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public_us_east_1b.id
}

resource "aws_route_table_association" "public_us_east_1c" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public_us_east_1c.id
}

resource "aws_route_table_association" "private_us_east_1a" {
  route_table_id = aws_route_table.private_us_east_1a.id
  subnet_id      = aws_subnet.private_us_east_1a.id
}

resource "aws_route_table_association" "private_us_east_1b" {
  route_table_id = aws_route_table.private_us_east_1b.id
  subnet_id      = aws_subnet.private_us_east_1b.id
}

resource "aws_route_table_association" "private_us_east_1c" {
  route_table_id = aws_route_table.private_us_east_1c.id
  subnet_id      = aws_subnet.private_us_east_1c.id
}