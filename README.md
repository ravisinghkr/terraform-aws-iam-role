# IAM Role Terraform Module

## Background

To create a role, we need to create a policy, a profile, a policy attachment and finally a role. Also sometimes we want to attach few more policies or attach any exisiting policy to the role. If we want to create multiple roles then, we need to create all these for each role.

Now to simplify this, I am creating this simple module which would need few inputs and its all done.

## Usage
1. Add the full policy in heredoc syntax as shown below
```hcl
module "iam-role" {
    source  = "ravisinghkr/iam-role/aws"
    version = "0.1.2"
    name = "myrole"
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
    tags = {
        Name = "TestRole"
        Environment = "Dev"
    }
}
```
2. Add the policies using template
```hcl
module "iam-role" {
    source  = "ravisinghkr/iam-role/aws"
    version = "0.1.2"
    name = "myrole"
    description = "myrole description"
    assume_role_policy = data.template_file.my_assume_policy.rendered
    existing_policy_arn = "arn:aws:iam::aws:policy/mypolicy"
    existing_policy_names_to_attach = ["base_policy", "base_policy1"]
}
```

## Providers

| Name | Version |
|------|---------|
|  aws | ~ v3.54.0 |


## Modules

No modules.


## Resources

- [iam_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy)
- [iam_user_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment)
- [iam_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile)
- [iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)


## Inputs

|Name                             |Description                                                        |Default                |Optional|
|---------------------------------|-------------------------------------------------------------------|--------------------   |---------|
|name                |Name of the role to be created                                    |n/a                 |No|
|description         |Description about the role to be created                          |""                  |Yes|
|assume_role_policy  |Policy for role to assume                                        | n/a                 |No|
|role_policy         |Policy to be associated to the role. This field will be ignored if `existing_policy_arn` is set|`See note section below`|`See note section below`|
|existing_policy_arn|Existing policy ARN to be attached to the role. `role_policy` field will be ignored if this field is set|""|`See note section below`|
|existing_policy_names_to_attach |Any existing policies to be associated to the role. Should be privided in form of a list     |[ ]|Yes|
|tags     |Tags to be added in the role, policy and instance profile |{}|Yes|

**Note: Any one of the input field `role_policy` or `existing_policy_arn` should be set. If both fields are not set then, `role_policy` field will have the following default value and `existing_policy_arn` field will be ignored**
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
|policy_arn|ARN of the associated policy, if `existing_policy_arn` field is not set|
