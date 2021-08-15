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

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  role       = aws_iam_role.role.name
  policy_arn = var.existing_policy_arn == "" ? (length(aws_iam_policy.policy) > 0 ? aws_iam_policy.policy[0].arn : "") : var.existing_policy_arn
}

resource "aws_iam_policy" "policy" {
  count = var.existing_policy_arn == "" ? 1 : 0
  name = "${var.name}_policy"
  policy = var.role_policy

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "common_policy_attachment" {
for_each = toset(var.existing_policy_names_to_attach)
  role       = aws_iam_role.role.name
  policy_arn = "aws_iam_policy.${each.key}.arn"
}