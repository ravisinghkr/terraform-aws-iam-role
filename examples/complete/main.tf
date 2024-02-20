module "iam-role" {
  source      = "ravisinghkr/iam-role/aws"
  version     = "1.0.0"
  name        = "myrole"
  description = "myrole description"

  assume_role_policy = <<EOF
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
  role_policy        = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::abcd",
                "arn:aws:s3:::abcd/*"
            ]
        }
    ]
}
EOF

  existing_policy_arns = ["arn:aws:iam::aws:policy/mypolicy", "arn:aws:iam::aws:policy/mybasepolicy"]

  tags = {
    Name        = "TestRole"
    Environment = "Dev"
  }
}
