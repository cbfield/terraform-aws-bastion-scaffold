resource "aws_instance" "bastion" {
  for_each = toset(var.subnets)

  ami                    = coalesce(var.ami, try(data.aws_ami.al2.0.id, null))
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.ec2_key.id
  subnet_id              = each.key
  vpc_security_group_ids = [coalesce(var.security_group_id, try(aws_security_group.bastion.0.id, null))]

  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "required"
  }

  tags = {
    "Managed By Terraform" = "true"
    "Name"                 = "${var.name}-${each.key}"
  }

  lifecycle {
    ignore_changes = [ami]
  }
}

resource "tls_private_key" "ssh_key" {
  count = var.public_key == null ? 1 : 0

  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ec2_key" {
  key_name = var.name

  public_key = coalesce(
    var.public_key,
    try(tls_private_key.ssh_key.0.public_key_openssh, null)
  )
  tags = {
    "Managed By Terraform" = "true"
    "Name"                 = var.name
  }
}

resource "aws_security_group" "bastion" {
  count = var.security_group_id == null ? 1 : 0

  description = "Manages ingress and egress for ${var.name} hosts"
  name        = var.name
  vpc_id      = var.vpc_id

  tags = {
    "Managed By Terraform" = "true"
    "Name"                 = var.name
  }
}

resource "aws_security_group_rule" "self_ingress" {
  count = var.security_group_id == null ? 1 : 0

  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.bastion.0.id
  self              = true
  to_port           = 22
  type              = "ingress"
}

resource "aws_security_group_rule" "cidr_ingress" {
  count = var.security_group_id == null && try(length(var.ingress.cidr_blocks) > 0, false) ? 1 : 0

  cidr_blocks       = var.ingress.cidr_blocks
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.bastion.0.id
  to_port           = 22
  type              = "ingress"
}

resource "aws_security_group_rule" "ipv6_cidr_ingress" {
  count = var.security_group_id == null && try(length(var.ingress.ipv6_cidr_blocks) > 0, false) ? 1 : 0

  ipv6_cidr_blocks  = var.ingress.ipv6_cidr_blocks
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.bastion.0.id
  to_port           = 22
  type              = "ingress"
}

resource "aws_security_group_rule" "sg_ingress" {
  for_each = var.security_group_id == null ? toset(coalesce(try(var.ingress.security_groups, null), [])) : toset([])

  from_port                = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.bastion.0.id
  source_security_group_id = each.key
  to_port                  = 22
  type                     = "ingress"
}

resource "aws_security_group_rule" "egress" {
  count = var.security_group_id == null ? 1 : 0

  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.bastion.0.id
  to_port           = 0
  type              = "egress"
}
