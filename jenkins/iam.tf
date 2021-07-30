resource "aws_iam_role" "jenkins" {
  name        = "${local.name_prefix}-jenkins-iam-role"
  description = "IAM role attached to Jenkins"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = merge(
    map(
      "Name", "${local.name_prefix}-jenkins-iam-role"
    ),
    local.common_tags
  )
}

data "aws_iam_policy_document" "s3_readwrite_policy_docuemnt" {
  statement {
    sid       = "AllObjectActions"
    effect    = "Allow"
    actions   = [
      "s3:ListBucket",
      "s3:*Object"
    ]
    resources = [
      "arn:aws:s3:::ee-pune-bootcamp-2021-tf-state",
      "arn:aws:s3:::ee-pune-bootcamp-2021-tf-state/*"
    ]
  }
}

resource "aws_iam_policy" "s3_readwrite_policy" {
  name        = "${local.name_prefix}-terraform-state-bucket-read-write-policy"
  description = "Allows all object actions on terraform state bucket for ${local.name_prefix}"
  policy      = data.aws_iam_policy_document.s3_readwrite_policy_docuemnt.json
}

resource "aws_iam_role_policy_attachment" "s3_policy_for_jenkins" {
  role       = aws_iam_role.jenkins.name
  policy_arn = aws_iam_policy.s3_readwrite_policy.arn
}

data "aws_iam_policy_document" "dynamo_readwrite_policy_document" {
  statement {
    sid    = "AllItemActions"
    effect = "Allow"
    actions = [
      "dynamodb:*Item"
    ]
    resources = ["arn:aws:dynamodb:us-east-1:038062473746:table/ee-pune-bootcamp-2021-terraform-lock-table"]
  }
}

resource "aws_iam_policy" "dynamo_readwrite_policy" {
  name        = "${local.name_prefix}-dynamo-read-write-policy"
  description = "Allows all item actions on terraform dynamo lock table for ${local.name_prefix}"
  policy      = data.aws_iam_policy_document.dynamo_readwrite_policy_document.json
}

resource "aws_iam_role_policy_attachment" "dynamo_policy_for_jenkins" {
  role       = aws_iam_role.jenkins.name
  policy_arn = aws_iam_policy.dynamo_readwrite_policy.arn
}

data "aws_iam_policy_document" "iam_policy_document" {
  statement {
    sid = "IAMPolicyForJenkins"
    actions = [
      "iam:AttachRolePolicy",
      "iam:DetachRolePolicy",
      "iam:*Role",
      "iam:ListAttachedRolePolicies",
      "iam:*InstanceProfile"
    ]
    effect    = "Allow"
    resources = ["*"]
  }
}

resource "aws_iam_policy" "jenkins_iam_policy" {
  name        = "${local.name_prefix}-jenkins-iam-policy"
  description = "IAM policy for ${local.name_prefix}-jenkins-iam-role"
  policy      = data.aws_iam_policy_document.iam_policy_document.json
}

resource "aws_iam_role_policy_attachment" "iam_policy_for_jenkins" {
  role       = aws_iam_role.jenkins.name
  policy_arn = aws_iam_policy.jenkins_iam_policy.arn
}

resource "aws_iam_role_policy_attachment" "ecr_readwrite_policy" {
  role       = aws_iam_role.jenkins.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}

resource "aws_iam_role_policy_attachment" "vpc_readonly_policy" {
  role       = aws_iam_role.jenkins.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonVPCReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "ec2_policy" {
  role       = aws_iam_role.jenkins.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_role_policy_attachment" "ecs_policy" {
  role       = aws_iam_role.jenkins.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonECS_FullAccess"

}

resource "aws_iam_instance_profile" "jenkins" {
  name = aws_iam_role.jenkins.name
  role = aws_iam_role.jenkins.name
}