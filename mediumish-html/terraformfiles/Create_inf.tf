//DevOps practice

terraform {
  required_providers {
    aws = {
        source  = "hashicorp/aws"
        version = "~> 3.0"
    }
  }
}

resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "WebServer"
  public_key = tls_private_key.example.public_key_openssh
}

provisioner "local-exec" {
  command = "echo '${tls_private_key.pk.private_key_pem}' > ./WebServer.pem"
} 

provider "aws" {}

resource "aws_instance" "WebServer"{
  ami = "ami-00399ec92321828f5"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.generated_key.key_name

  user_data = file("/var/lib/jenkins/ssh_connection.sh")

  tags = {
    Name = "Web Server"
    Owner = "Dmytro Kolomiiets"
  }
}
