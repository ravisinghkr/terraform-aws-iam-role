# IAM Role Terraform Module

## Background

To create a role, we need to create a policy, a profile, a policy attachment and finally a role. Also sometimes we want to attach few more policies or attach any exisiting policy to the role. If we want to create multiple roles then, we need to create all these for each role.

Now to simplify this, I am creating this simple module which would need few inputs and its all done.

## Usage
1. Setting all the input values. Setting `assume_role_policy` and `role_policy` fields using heredoc syntax
```hcl
module "iam-role" {
    source  = "ravisinghkr/iam-role/aws"
    version = "0.1.3"
    name = "myrole"
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
          "Effect": "Allow",
          "Sid": ""
        }
      ]
    }
    EOF
    role_policy = <<EOF
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
        Name = "TestRole"
        Environment = "Dev"
    }
}
```
2. Using template to set `assume_role_policy` field
```hcl
module "iam-role" {
    source  = "ravisinghkr/iam-role/aws"
    version = "0.1.3"
    name = "myrole"
    description = "myrole description"
    assume_role_policy = data.template_file.my_assume_policy.rendered
    existing_policy_arns = ["arn:aws:iam::aws:policy/mypolicy"]
    role_policy = <<EOF
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
}
```

## Providers

| Name | Version |
|------|---------|
|  aws | >= 3.40.0 |


## Modules

No modules.


## Resources

- [iam_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy)
- [iam_user_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment)
- [iam_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile)
- [iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)


## Inputs

|Name                             |Description                                                        |Default                  |Optional |
|---------------------------------|-------------------------------------------------------------------|-------------------------|---------|
|name                |Name of the role to be created                                                  |n/a                      |No       |
|description         |Description about the role to be created                                        |""                       |Yes      |
|assume_role_policy  |Policy for role to assume                                                       |n/a                     |No       |
|role_policy         |Policy to be associated to the role.                                            |`See note section below` |Yes      |
|existing_policy_arns|Existing policy ARNs to be attached to the role.                                |[]                       |Yes      |
|tags                |Tags to be added in the role, policy and instance profile                       |{}                       |Yes      |

**Note: Any one of the input field `role_policy` or `existing_policy_arns` should be set. If both fields are not set then, `role_policy` field will have the following default value**
```hcl
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
```

## Outputs

|Name                   | Description                                                  |
|-----------------------|------------------------------------------------------|
|role_arn|ARN of the IAM role created|
|instance_profile_arn|ARN of the associated Instance Profile|
|policy_arn|ARN of the policy created|
