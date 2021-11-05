This is the simplest usage of this module. This creates a single bastion host in the subnet `subnet-123123`, within the VPC `vpc-12123`.

In this example, the module creates both the ssh-rsa keypair that is used to connect to the instances, and the security group that is assigned to each of the instances. The AMI used on each instance is the latest Amazon Linux 2 image.

```hcl
module "my_bastion_scaffold" {
  source = "../../"

  name    = "testy-mctesterson"
  vpc_id  = "vpc-123123"
  subnets = ["subnet-123123"]
}
```