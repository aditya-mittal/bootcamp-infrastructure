data "aws_lb" "main_alb" {
  arn = local.alb_arn
}

data "aws_lb_listener" "alb_port_443_listener" {
  load_balancer_arn = local.alb_arn
  port              = 443
}

resource "aws_lb_target_group" "jenkins_tg" {
  name        = "${local.name_prefix}-jenkins-tg"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = local.vpc_id
  target_type = "instance"

  health_check {
    interval            = 60
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 10
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher             = "403"
  }

  tags = merge(
    map(
      "Name", "${local.name_prefix}-jenkins-tg"
    ),
    local.common_tags
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group_attachment" "jenkins_tg_attachment" {
  target_group_arn = aws_lb_target_group.jenkins_tg.arn
  target_id        = aws_instance.jenkins.id
  port             = 8080

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_listener_rule" "forward_to_jenkins" {
  listener_arn = data.aws_lb_listener.alb_port_443_listener.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.jenkins_tg.arn
  }

  condition {
    host_header {
      values = ["REPLACE-USERNAME.jenkins.bootcamp2021.online"]
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}