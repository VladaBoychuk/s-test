provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "web_server" {
  ami           = "ami-0c1ac8a41498c1a9c" 
  instance_type = "t3.micro"

  tags = {
    Name = "web-server"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
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