resource "aws_ecs_cluster" "main" {
  name = local.cluster_name

  tags = merge(
    map(
      "Name", "${local.name_prefix}-cluster"
    ),
    local.common_tags
  )

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}