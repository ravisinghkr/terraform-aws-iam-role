# Complete example
Example usage with all the variables used in the module

## Usage
To run this example you need to execute:
```hcl
$ terraform init
$ terraform plan
$ terraform apply
```

## Requirements
| Name      | Version    |
|-----------|------------|
| terraform | >= 1.0     |
| aws       | >= 3.40.0  |

## Providers
| Name | Version    |
|------|---------   |
|  aws | >= 3.40.0  |


## Modules
No modules.


## Resources
- [iam_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy)
- [iam_user_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment)
- [iam_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile)
- [iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)


## Inputs
No inputs.

## Outputs
|Name                   | Description                                          |
|-----------------------|------------------------------------------------------|
|role_arn|ARN of the IAM role created|
|instance_profile_arn|ARN of the associated Instance Profile|
|policy_arn|ARN of the policy created|
