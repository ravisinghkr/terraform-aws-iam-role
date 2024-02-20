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

  default_assume_role_policy = <<EOF
{
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Principal": {
             "Service": "ec2.amazonaws.com"
          },
          "Effect": "Allow"
        }
      ]
    }
EOF

  policy_arns        = var.role_policy == "" && length(var.existing_policy_arns) > 0 ? var.existing_policy_arns : (concat(var.existing_policy_arns, [aws_iam_policy.policy[0].arn]))
  policy_count       = var.role_policy == "" && length(var.existing_policy_arns) > 0 ? 0 : 1
  role_policy        = var.role_policy == "" && length(var.existing_policy_arns) == 0 ? local.default_policy : var.role_policy
  assume_role_policy = var.assume_role_policy != "" ? var.assume_role_policy : local.default_assume_role_policy
}
