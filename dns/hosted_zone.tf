resource "aws_route53_zone" "main" {
  name = local.domain_name

  tags = merge(
    map(
      "Name", "${local.name_prefix}-jenkins"
    ),
    local.common_tags
  )
}