output "iam_role_arn" {
  value = aws_iam_role.role.arn
  description = "ARN of the IAM role created"
}
