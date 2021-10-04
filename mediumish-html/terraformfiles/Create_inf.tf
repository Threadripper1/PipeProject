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

  user_data = file("/var/lib/jenkins/.ssh/id_rsa")

  tags = {
    Name = "Web Server"
    Owner = "Dmytro Kolomiiets"
  }
}
