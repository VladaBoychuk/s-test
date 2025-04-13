provider "aws" {
  region = "eu-north-1"
}

resource "aws_key_pair" "deployer" {
  key_name   = "ansible-key"
  public_key = var.ssh_public_key
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name = "HelloWorld"
  }
}}

output "public_ip" {
  value = aws_instance.web_server.public_ip
}
