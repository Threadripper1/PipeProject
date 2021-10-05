//DevOps practice

terraform {
  required_providers {
    aws = {
        source  = "hashicorp/aws"
        version = "~> 3.0"
    }
  }
}

resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "WebServer"
  public_key = tls_private_key.key.public_key_openssh
}

provider "aws" {}

resource "aws_instance" "WebServer"{
  ami = "ami-00399ec92321828f5"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.generated_key.key_name

  user_data = file("/var/lib/jenkins/ssh_connection.sh")

  provisioner "local-exec" { 
    working_dir = "/home/ubuntu"
    command = "touch WebServer.pem && echo '${tls_private_key.key.private_key_pem}' >> ~/${aws_key_pair.generated_key.key_name}.pem && chmod 400 ./'${aws_key_pair.generated_key.key_name}'.pem"
  }

  tags = {
    Name = "Web Server"
    Owner = "Dmytro Kolomiiets"
  }
}
