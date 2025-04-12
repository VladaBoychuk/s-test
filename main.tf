provider "aws" {
  region = "eu-north-1"
}

resource "aws_key_pair" "deployer" {
  key_name   = "ansible-key"
  public_key = var.ssh_public_key
}

resource "aws_instance" "web_server" {
  ami           = "ami-0c1ac8a41498c1a9c" # Ubuntu AMI
  instance_type = "t3.micro"
  key_name      = aws_key_pair.deployer.key_name

  tags = {
    Name = "web-server"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = var.ssh_private_key
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y ansible"
    ]
  }
}

output "public_ip" {
  value = aws_instance.web_server.public_ip
}
