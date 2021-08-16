locals {
  default_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:Get*",
                "s3:List*"
            ],
            "Resource": "*"
        }
    ]
}
EOF
  policy_arns = var.role_policy == "" && length(var.existing_policy_arns) > 0 ? var.existing_policy_arns : (concat(var.existing_policy_arns, [aws_iam_policy.policy[0].arn]))
}

resource "aws_iam_role" "role" {
  name               = var.name
  description        = var.description
  assume_role_policy = var.assume_role_policy

  tags = var.tags
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = var.name
  role = aws_iam_role.role.name

  tags = var.tags
}

resource "aws_iam_policy" "policy" {
  count = var.role_policy == "" && length(var.existing_policy_arns) > 0 ? 0 : 1
  name = "${var.name}_policy"
  policy = var.role_policy == "" && length(var.existing_policy_arns) == 0 ? local.default_policy : var.role_policy

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
for_each = toset(local.policy_arns)
  role       = aws_iam_role.role.name
  policy_arn = each.key
} 