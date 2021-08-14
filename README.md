# IAM Role Terraform Module

## Background

To create a role, we need to create a policy, a profile, a policy attachment and finally a role. Also sometimes we want to attach few more policies or attach any exisiting policy to the role. If we want to create multiple roles then, we need to create all these for each role.

Now to simplify this, I am creating this simple module which would need few inputs and its all done.

## Usage
1. Add the full policy in heredoc syntax as shown below
```hcl
module "terraform-aws-iam-role" {
    source = "terraform-aws-iam-role"
    version = "~0.1.0"
    name = "myrole"
    description = "myrole description"
    assumed_role_policy = <<EOF
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
                    "s3:GetObject",
                    "s3:GetObjectVersion",
                    "s3:GetBucketLocation",
                    "s3:PutObject",
                    "s3:DeleteObject"
                ],
                "Resource": [
                    "arn:aws:s3:::abcd",
                    "arn:aws:s3:::abcd/*"
                ]
            }
        ]
    }
    EOF
    existing_policy_names_to_attach = []
}
```
2. Add the policies using template
```hcl
module "terraform-aws-iam-role" {
    source = "terraform-aws-iam-rol"
    version = "~0.1.0"
    name = "myrole"
    description = "myrole description"
    assumed_role_policy = data.template_file.common_mongo_atlas_assume_role.rendered
    role_policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": [
                    "s3:ListBucket",
                    "s3:GetObject",
                    "s3:GetObjectVersion",
                    "s3:GetBucketLocation",
                    "s3:PutObject",
                    "s3:DeleteObject"
                ],
                "Resource": [
                    "arn:aws:s3:::abcd",
                    "arn:aws:s3:::abcd/*"
                ]
            }
        ]
    }
    EOF
    existing_policy_names_to_attach = ["base_policy"]
}
```

## Providers

| Name | Version |
|------|---------|
|  aws | any |


## Modules

No modules.


## Resources

- [iam_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy)
- [iam_user_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment)
- [iam_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile)
- [iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)


## Inputs

|Name                             |Description                                                            |Default             |Optional|
|---------------------------------|-----------------------------------------------------------------------|--------------------|---------|
|name                                |Name of the role to be created                                    |n/a                 |No|
|description                         |Description about the role to be created                          |""                  |Yes|
|assumed_role_policy                 |Policy for role to assume                                        | n/a                 |No|
|role_policy                         |Policy to be associated to the role                               |n/a                 |No|
|existing_policy_names_to_attach     |Any existing policies to be associated to the role. Should be privided in form of a list     |[ ]                 |Yes|
                                          

## Outputs

iam_role_arn
