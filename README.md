# terraform-aws-bastion-scaffold

This is a Terraform module that creates a collection of SSH bastion hosts within an AWS VPC.

My intention with this is primarily for usage as a debugging tool. It's nice to be able to test network connections between two given subnets, and a convenient way to do that is via SSH bastion hosts. This module makes it possible to create a network of bastion hosts that allow ssh traffic from each other, so I can quickly connect to a shell hosted from a certain network space and run connectivity tests from there.

# Terraform Docs

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_instance.bastion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_key_pair.ec2_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_security_group.bastion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.cidr_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ipv6_cidr_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.self_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.sg_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [tls_private_key.ssh_key](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [aws_ami.al2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami"></a> [ami](#input\_ami) | An AMI to use when creating each bastion host. The latest Amazon Linux 2 AMI will be used as a default | `string` | `null` | no |
| <a name="input_ingress"></a> [ingress](#input\_ingress) | Configuration for sources that are allowed to connect to the bastion hosts (cidr blocks or security group IDs)<br>This argument is only used when var.security\_group\_id is not provided | <pre>object({<br>    cidr_blocks      = optional(list(string))<br>    ipv6_cidr_blocks = optional(list(string))<br>    security_groups  = optional(list(string))<br>  })</pre> | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | The name to assign to resources created by this module | `string` | n/a | yes |
| <a name="input_public_key"></a> [public\_key](#input\_public\_key) | The public key for a keypair to use when connecting to the bastion hosts. One will be created if not provided | `string` | `null` | no |
| <a name="input_security_group_id"></a> [security\_group\_id](#input\_security\_group\_id) | A security group to apply to each bastion host. One will be created if not provided | `string` | `null` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | IDs of subnets in which to create bastion hosts | `list(string)` | `[]` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC in which these bastion hosts will be created<br>Required if var.security\_group\_id is not provided | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ami"></a> [ami](#output\_ami) | The provided value for var.ami |
| <a name="output_ec2_key"></a> [ec2\_key](#output\_ec2\_key) | The AWS EC2 key pair assigned to each instance |
| <a name="output_ingress"></a> [ingress](#output\_ingress) | The provided value for var.ingress |
| <a name="output_instances"></a> [instances](#output\_instances) | The instances created by this module |
| <a name="output_name"></a> [name](#output\_name) | The provided value for var.name |
| <a name="output_public_key"></a> [public\_key](#output\_public\_key) | The provided value for var.public\_key |
| <a name="output_security_group"></a> [security\_group](#output\_security\_group) | The security group created for the instances, if one was not provided |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The provided value for var.security\_group\_id |
| <a name="output_ssh_key"></a> [ssh\_key](#output\_ssh\_key) | The SSH RSA key to be used to connect to the instances, if one was not provided |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | The provided value for var.subnets |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The provided value for var.vpc\_id |
