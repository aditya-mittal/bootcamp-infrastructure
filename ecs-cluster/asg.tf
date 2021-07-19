resource "aws_autoscaling_group" "ecs_cluster_asg" {
  name                 = "${local.cluster_name}-asg"
  launch_configuration = aws_launch_configuration.ecs_launch_config.name

  desired_capacity = 1
  min_size         = 1
  max_size         = 1

  default_cooldown  = 300
  health_check_type = "EC2"

  vpc_zone_identifier = data.aws_subnet_ids.private_subnets.ids

  termination_policies = [
    "OldestInstance",
    "Default"
  ]

  tags = [
    {
      key                 = "Name"
      propagate_at_launch = true
      value               = "${local.name_prefix}-ecs-cluster-instance"
    },
    {
      key                 = "CreatedBy"
      propagate_at_launch = true
      value               = "terraform"
    },
    {
      key                 = "MaintainerSlackHandle"
      propagate_at_launch = true
      value               = "${local.name_prefix}-devs"
    }
  ]

  enabled_metrics = [
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances"
  ]

  lifecycle {
    create_before_destroy = true
  }
}