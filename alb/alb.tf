resource "aws_lb" "main" {
  name_prefix     = "main-"
  internal        = false
  security_groups = [aws_security_group.alb_sg.id]
  subnets         = data.aws_subnet_ids.public_subnets.ids

  tags = merge(
    map(
      "Name", "${local.name_prefix}-main-alb"
    ),
    local.common_tags
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type = "redirect"

    redirect {
      status_code = "HTTP_301"
      port        = "443"
      protocol    = "HTTPS"
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.main.arn
  port              = 443
  protocol          = "HTTPS"

  certificate_arn = local.ssl_cert_arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Hello aditya, welcome to EE Bootcamp!"
      status_code  = "200"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}
