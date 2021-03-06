resource "aws_security_group" "jenkins_sg" {
  name        = "${local.name_prefix}-jenkins-sg"
  description = "Security group for Jenkins"
  vpc_id      = local.vpc_id
  tags = merge(
    map(
      "Name", "${local.name_prefix}-jenkins-sg"
    ),
    local.common_tags
  )
}

resource "aws_security_group_rule" "jenkins_ingress_rule_8080_allow_alb" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = local.alb_sg_id

  description       = "Allow ingress on port 8080 to alb"
  security_group_id = aws_security_group.jenkins_sg.id
}

resource "aws_security_group_rule" "jenkins_egress_rule_allow_all" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  description       = "Allow egress to everything"
  security_group_id = aws_security_group.jenkins_sg.id
}