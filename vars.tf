variable "ec2_ami" {
  type = map(any)

  default = {
    us-east-1 = "ami-070650c005cce4203"
  }
}

# Creating a Variable for region

variable "region" {
  default = "us-east-1"
}

# Creating a Variable for instance_type
variable "instance_type" {
  type = string
}

# Creating a Variable for security_group
variable "security_group" {
  default     = "open_ports"
  description = "Security group name"
}

# Creating a Variable for key_name
variable "key_name" {
  default     = "ansible"
  description = "Key Pair name"
}