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
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Welcome to EE Bootcamp!"
      status_code  = "200"
    }
  }
}
