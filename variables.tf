variable name {
    description = "Name of the role to be created"
}

variable description {
    description = "Description about the role to be created"
    default = ""
}

variable assumed_role_policy {
    description = "Policy for role to assume. Should be in the heredoc syntax, jsonencode function or the policy arn"
}

variable role_policy {
    description = "Policy to be associated to the role. Should be in the heredoc syntax, jsonencode function or the policy arn"
}

variable existing_policy_names_to_attach {
    description = "Any existing policies to be associated to the role. Should be privided in form of a list"
    default=[]
}

variable revesion {
    description = "Revesion number of the application"
    default = "v0.1.0"
}
