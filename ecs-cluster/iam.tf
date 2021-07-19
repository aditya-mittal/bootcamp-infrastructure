resource "aws_iam_role" "ecs_role" {
  name        = "${local.name_prefix}-ecs-instance-role"
  description = "Allows EC2 instances in an ECS cluster to access ECS"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole",
      "Sid": ""
    }
  ]
}
EOF

  tags = merge(
    map(
      "Name", "${local.name_prefix}-ecs-instance-role"
    ),
    local.common_tags
  )
}

resource "aws_iam_role_policy_attachment" "ecr_policy" {
  role       = aws_iam_role.ecs_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "ecs" {
  name = aws_iam_role.ecs_role.name
  role = aws_iam_role.ecs_role.name
}