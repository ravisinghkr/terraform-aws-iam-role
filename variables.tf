variable "name" {
  description = "Name of the role to be created."
  type        = string
}

variable "description" {
  description = "Description about the role to be created."
  default     = ""
  type        = string
}

variable "assume_role_policy" {
  description = "Policy for the role to assume. Should be in the heredoc syntax or jsonencode function."
  default     = ""
  type        = string
}

variable "role_policy" {
  description = "Policy to be associated to the role. Should be in the heredoc syntax or jsonencode function."
  default     = ""
  type        = string
}

variable "existing_policy_arns" {
  description = "Existing policies to be attached to the role."
  default     = []
  type        = list(string)
}

variable "tags" {
  description = "Tags to be added in the role, policy and instance profile."
  default     = {}
  type        = map(string)
}
