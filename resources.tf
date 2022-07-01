resource "aws_instance" "vault" {
  ami           = lookup(var.ec2_ami, var.region)
  instance_type = var.instance_type
  tags = {
    Name = "vault"
  }

  provisioner "local-exec" {
    command = <<-EOF
    echo '[${aws_instance.vault.tags.Name}]' > hosts
    echo '${aws_instance.vault.public_ip}' >> hosts
    echo '\n[all:vars]' >> hosts
    echo 'ansible_user = ubuntu' >> hosts
    echo 'ansible_ssh_private_key_file = ansible.pem' >> hosts
  EOF
  }
}