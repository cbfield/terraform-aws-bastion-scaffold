module "my_bastion_scaffold" {
  source = "../../"

  name    = "testy-mctesterson"
  vpc_id  = "vpc-123123"
  subnets = ["subnet-123123"]
}
