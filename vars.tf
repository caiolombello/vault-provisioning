variable "ec2_ami" {
  type = map(any)

  default = {
    us-east-1 = "ami-070650c005cce4203"
  }
}

# region
variable "region" {
  default = "us-east-1"
}

# instance_type
variable "instance_type" {
  type = string
}

# security_group
variable "security_group" {
  default     = "open_ports"
  description = "Security group name"
}

# key_name
variable "key_name" {
  default     = "ansible"
  description = "Key Pair name"
}

# AWS Profile
variable "aws_profile" {
  type    = string
  default = "caiolvbarbieri"
}