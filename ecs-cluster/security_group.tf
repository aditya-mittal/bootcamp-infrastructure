resource "aws_security_group" "cluster_sg" {
  name        = "${local.name_prefix}-ecs-cluster-sg"
  description = "Security group for ECS cluster container instances"
  vpc_id      = local.vpc_id
  tags = merge(
    map(
      "Name", "${local.name_prefix}-ecs-cluster-sg"
    ),
    local.common_tags
  )
}

resource "aws_security_group_rule" "cluster_ingress_rule_alb_access" {
  type                     = "ingress"
  from_port                = 32768
  to_port                  = 61000
  protocol                 = "tcp"
  source_security_group_id = local.alb_sg_id

  description       = "Allow ingress from alb to ECS container instance"
  security_group_id = aws_security_group.cluster_sg.id
}

resource "aws_security_group_rule" "cluster_egress_rule_allow_all" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  description       = "Allow egress to everything"
  security_group_id = aws_security_group.cluster_sg.id
}
