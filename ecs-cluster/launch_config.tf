data "aws_ami" "ecs_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = ["amazon"]
}

data "template_file" "ecs_userdata" {
  template = file("userdata.sh.tpl")

  vars = {
    cluster_name = local.cluster_name
  }
}

resource "aws_launch_configuration" "ecs_launch_config" {
  name                 = "${local.name_prefix}-ecs"
  image_id             = data.aws_ami.ecs_ami.id
  instance_type        = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.ecs.name
  user_data            = data.template_file.ecs_userdata.rendered
  security_groups      = [aws_security_group.cluster_sg.id]

  // try to define spot price
  #spot_price = "TBD"

  root_block_device {
    volume_size           = 30
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }
}