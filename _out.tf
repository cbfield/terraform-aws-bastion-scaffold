output "ami" {
  description = "The provided value for var.ami"
  value       = var.ami
}

output "ec2_key" {
  description = "The AWS EC2 key pair assigned to each instance"
  value       = aws_key_pair.ec2_key
}

output "ingress" {
  description = "The provided value for var.ingress"
  value       = var.ingress
}

output "instances" {
  description = "The instances created by this module"
  value       = aws_instance.bastion
}

output "name" {
  description = "The provided value for var.name"
  value       = var.name
}

output "public_key" {
  description = "The provided value for var.public_key"
  value       = var.public_key
}

output "security_group" {
  description = "The security group created for the instances, if one was not provided"
  value       = one(aws_security_group.bastion)
}

output "security_group_id" {
  description = "The provided value for var.security_group_id"
  value       = var.security_group_id
}

output "ssh_key" {
  description = "The SSH RSA key to be used to connect to the instances, if one was not provided"
  sensitive   = true
  value       = one(tls_private_key.ssh_key)
}

output "subnets" {
  description = "The provided value for var.subnets"
  value       = var.subnets
}

output "vpc_id" {
  description = "The provided value for var.vpc_id"
  value       = var.vpc_id
}
