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
  ami = "ami-00dfe2c7ce89a450b"
  instance_type = "t2.micro"

  subnet_id = subnet-d9d851b2
  private_ip = "172.31.5.250"

  tags = {
    Name = "Web Server"
    Owner = "Dmytro Kolomiiets"
  }
}
