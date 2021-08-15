variable name {
    description = "Name of the role to be created."
}

variable description {
    description = "Description about the role to be created."
    default = ""
}

variable assume_role_policy {
    description = "Policy for the role to assume. Should be in the heredoc syntax or jsonencode function."
}

variable role_policy {
    description = "Policy to be associated to the role. Should be in the heredoc syntax or jsonencode function. This field will be ignored if 'existing_policy_arn' field is set"
    default = <<EOF
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

}

variable existing_policy_arn {
    description = "Existing policy ARN to be attached to the role. 'role_policy' field will be ignored if this field is set"
    default = ""
}

variable existing_policy_names_to_attach {
    description = "Any existing policies to be associated to the role. Should be privided in form of a list."
    default=[]
}

variable tags {
    description = "Tags to be added in the role, policy and instance profile"
    default= {} 
}
