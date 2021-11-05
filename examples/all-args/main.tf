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
