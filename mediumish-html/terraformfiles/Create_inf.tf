//DevOps practice

terraform {
  required_providers {
    aws = {
        source  = "hashicorp/aws"
        version = "~> 3.0"
    }
  }
}

variable "key_name" {}

resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.example.public_key_openssh
}

provider "aws" {}

resource "aws_instance" "Main"{
  ami = "ami-00399ec92321828f5"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.generated_key.key_name

  user_data = file("/var/lib/jenkins/ssh_connection.sh")

  tags = {
    Name = "Web Server"
    Owner = "Dmytro Kolomiiets"
  }
}
