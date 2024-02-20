resource "aws_iam_role" "role" {
  name               = var.name
  description        = var.description
  assume_role_policy = local.assume_role_policy

  tags = var.tags
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = var.name
  role = aws_iam_role.role.name

  tags = var.tags
}

resource "aws_iam_policy" "policy" {
  count  = local.policy_count
  name   = "${var.name}_policy"
  policy = local.role_policy

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  count      = length(local.policy_arns)
  role       = aws_iam_role.role.name
  policy_arn = local.policy_arns[count.index]
}
