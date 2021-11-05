variable "ami" {
  description = "An AMI to use when creating each bastion host. The latest Amazon Linux 2 AMI will be used as a default"
  type        = string
  default     = null
}

variable "ingress" {
  description = <<-EOF
    Configuration for sources that are allowed to connect to the bastion hosts (cidr blocks or security group IDs)
    This argument is only used when var.security_group_id is not provided
    EOF
  type = object({
    cidr_blocks      = optional(list(string))
    ipv6_cidr_blocks = optional(list(string))
    security_groups  = optional(list(string))
  })
  default = {}
}

variable "name" {
  description = "The name to assign to resources created by this module"
  type        = string
}

variable "public_key" {
  description = "The public key for a keypair to use when connecting to the bastion hosts. One will be created if not provided"
  type        = string
  default     = null
}

variable "security_group_id" {
  description = "A security group to apply to each bastion host. One will be created if not provided"
  type        = string
  default     = null
}

variable "subnets" {
  description = "IDs of subnets in which to create bastion hosts"
  type        = list(string)
  default     = []
}

variable "vpc_id" {
  description = <<-EOF
    The ID of the VPC in which these bastion hosts will be created
    Required if var.security_group_id is not provided
    EOF
  type        = string
  default     = ""
}
