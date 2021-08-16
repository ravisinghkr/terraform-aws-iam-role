output "role_arn" {
  value = aws_iam_role.role.arn
  description = "ARN of the role created"
}

output "instance_profile_arn" {
  value = aws_iam_instance_profile.instance_profile.arn
  description = "ARN of the associated Instance Profile."
}

output "policy_arn" {
  value = length(aws_iam_policy.policy) > 0 ? aws_iam_policy.policy[0].arn : "New policy was not created as existing policy was supplied."
  description = "ARN of the policy created"
}
