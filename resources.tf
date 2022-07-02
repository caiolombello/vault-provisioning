resource "aws_instance" "vault" {
  ami                    = lookup(var.ec2_ami, var.region)
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.open_ports.id]
  key_name               = aws_key_pair.generated_key.key_name

  tags = {
    Name = "vault"
  }

  provisioner "local-exec" {
    command = <<-EOF
    echo '[${aws_instance.vault.tags.Name}]' > hosts
    echo '${aws_instance.vault.public_ip}' >> hosts
    echo -e '\n[all:vars]' >> hosts
    echo 'ansible_user = ubuntu' >> hosts
    echo 'ansible_ssh_private_key_file = ansible.pem' >> hosts
  EOF
  }
}