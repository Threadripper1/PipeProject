//DevOps practice test

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

resource "aws_security_group" "WebServer" {
  name = "Web Server Security groups"
  description = "For Web Server"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port =  0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "WebServer"{
  ami = "ami-00399ec92321828f5"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.generated_key.key_name
  vpc_security_group_ids = [aws_security_group.WebServer.id]
  private_ip = "172.31.0.5"

  user_data = file("/var/lib/jenkins/ssh_connection.sh")

  provisioner "local-exec" { 
    command = "rm ${aws_key_pair.generated_key.key_name}.pem && touch WebServer.pem && echo '${tls_private_key.key.private_key_pem}' >> ${aws_key_pair.generated_key.key_name}.pem"
  }

  tags = {
    Name = "Web Server"
    Owner = "Dmytro Kolomiiets"
  }
}
