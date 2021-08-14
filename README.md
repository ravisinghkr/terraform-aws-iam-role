**IAM Role Terraform Module**

**Background**

To create a role, we need to create a policy, a profile, a policy attachment and finally a role. Also sometimes we want to attach few more policies or attach any exisiting policy to the role. If we want to create multiple roles then, we need to create all these for each role.

Now to simplify this, I am creating this simple module which would need few inputs and its all done.


**Usage**

module "terraform-aws-iam-role" {
    source = ""
    version = "~0.1.0"

}


**Providers**

|Name       |Version    |


|aws        |any        |


**Modules**

No modules.


**Resources**

iam_policy

iam_user_policy_attachment

iam_instance_profile

iam_role


**Inputs**

Name                                 Description                                                        Type                    Default             Mandatory
name                                : Name of the role to be created                                    string                    n/a                 Yes
description                         : Description about the role to be created                          string                    ""                  No
assumed_role_policy                 : Policy for role to assume                                         string                    n/a                 Yes
role_policy                         : Policy to be associated to the role                               string                    n/a                 Yes
existing_policy_names_to_attach     : Any existing policies to be associated to the role. Should be     list                      []                  No
                                     privided in form of a list      

**Outputs**

iam_policy_arn
