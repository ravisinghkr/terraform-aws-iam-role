resource "aws_iam_role" "role" {
  name               = var.name
  description        = var.description
  assume_role_policy = var.assumed_role_policy

  tags = {
      release = var.revesion
  }
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = var.name
  role = aws_iam_role.role.name

  tags = {
      release = var.revesion
  }
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy.arn
}

resource "aws_iam_policy" "policy" {
  name = "${var.name}_policy_attach"
  policy = var.role_policy

  tags = {
      release = var.revesion
  }
}

resource "aws_iam_role_policy_attachment" "common_policy_attachment" {
for_each = toset(var.existing_policy_names_to_attach)
  role       = aws_iam_role.role.name
  policy_arn = "aws_iam_policy.${each.key}.arn"
}