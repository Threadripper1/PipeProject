//DevOps practice

# terraform {
#   required_providers {
#     aws = {
#         source  = "hashicorp/aws"
#         version = "~> 3.0"
#     }
#   }
# }

provider "aws" {
    region = "us-east-2"
}

resource "aws_instance" "Main"{
    ami = "ami-00dfe2c7ce89a450b"
    instance_type = "t2.micro"

    tags = {
      Name = "Main Server"
      Owner = "Dmytro Kolomiiets"
    }
}
