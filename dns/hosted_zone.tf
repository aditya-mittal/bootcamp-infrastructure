resource "aws_route53_zone" "main" {
  name = "bootcamp2021.online"

  tags = merge(
  map(
  "Name", "${local.name_prefix}-jenkins"
  ),
  local.common_tags
  )
}