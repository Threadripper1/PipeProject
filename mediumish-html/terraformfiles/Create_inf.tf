//DevOps practice

terraform {
  required_providers {
    aws = {
        source  = "hashicorp/aws"
        version = "~> 3.0"
    }
  }
}

provider "aws" {}

resource "aws_instance" "Main"{
  vpc = true
  network_interface = ec2-18-189-99-123.us-east-2.compute.amazonaws.com
  ami = "ami-00dfe2c7ce89a450b"
  instance_type = "t2.micro"

  tags = {
    Name = "Web Server"
    Owner = "Dmytro Kolomiiets"
  }
}
