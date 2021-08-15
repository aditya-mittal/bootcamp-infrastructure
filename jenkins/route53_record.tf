data "aws_route53_zone" "main" {
  name         = "bootcamp2021.online"
  private_zone = false
}

resource "aws_route53_record" "jenkins" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "REPLACE-USERNAME.jenkins.${data.aws_route53_zone.main.name}"
  type    = "A"

  alias {
    name                   = data.aws_lb.main_alb.dns_name
    zone_id                = data.aws_lb.main_alb.zone_id
    evaluate_target_health = true
  }
}