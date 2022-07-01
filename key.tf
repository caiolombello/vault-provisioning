# Generating SSH key
resource "tls_private_key" "tls-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create key pair in AWS
resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.tls-key.public_key_openssh
}

# Create pem key file and alter permissions
resource "local_file" "pem_key_file" {
  content  = tls_private_key.tls-key.private_key_pem
  filename = "${var.key_name}.pem"

  provisioner "local-exec" { # Apply IP to Ansible
    command = "chmod 400 ${var.key_name}.pem"
  }
}