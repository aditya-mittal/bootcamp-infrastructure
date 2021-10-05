resource "aws_subnet" "private_us_east_1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.0/19"
  availability_zone = "us-east-1a"

  tags = merge(
    map(
      "Name", "${local.name_prefix}-private-subnet-us-east-1a",
      "Type", "private"
    ),
    local.common_tags
  )
}

resource "aws_subnet" "public_us_east_1a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.32.0/20"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = merge(
    map(
      "Name", "${local.name_prefix}-public-subnet-us-east-1a",
      "Type", "public"
    ),
    local.common_tags
  )

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_subnet" "private_us_east_1b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.64.0/19"
  availability_zone = "us-east-1b"

  tags = merge(
    map(
      "Name", "${local.name_prefix}-private-subnet-us-east-1b",
      "Type", "private"
    ),
    local.common_tags
  )
}

resource "aws_subnet" "public_us_east_1b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.96.0/20"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = merge(
    map(
      "Name", "${local.name_prefix}-public-subnet-us-east-1b",
      "Type", "public"
    ),
    local.common_tags
  )

  depends_on = [aws_internet_gateway.igw]
}
