This example uses every available argument for the module. This creates two bastion hosts, in the subnets `subnet-123123` and `subnet-234234`, within the VPC `vpc-123123`.

In this example, an ssh public key and AMI are provided to the module, so the module will not decide the AMI itself and will not create an ssh-rsa keypair to use when connecting to the instances. 

An example of `var.security_group_id` is given, but not used because `var.security_group_id` conflicts with `var.ingress`. `var.ingress` adds ingress rules to the security group created by the module, unless `var.security_group_id` is given. In that case, the arguments provided for `var.ingress` are not used.

```hcl
module "my_bastion_scaffold" {
  source = "../../"

  name = "testy-mctesterson"

  vpc_id = "vpc-123123"
  subnets = [
    "subnet-123123",
    "subnet-234234",
  ]

  ami        = "ami-123123"
  public_key = "ssh-rsa 123123123123123"

  # security_group_id = "sg-123123" # conflicts with var.ingress
  ingress = {
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    security_groups  = ["sg-123123"]
  }
}

```