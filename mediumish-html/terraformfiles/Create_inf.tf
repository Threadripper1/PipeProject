//DevOps practice

terraform {
  required_providers {
    aws = {
        source  = "hashicorp/aws"
        version = "~> 3.0"
    }
  }
}

resource "aws_vpc" "default" {
  cidr_block           = "172.31.0.0/16"
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.default.vpc-d4f395bf
}

resource "aws_subnet" "tf_test_subnet" {
  vpc_id                  = aws_vpc.default.vpc-d4f395bf
  cidr_block              = "172.31.0.0/20"
  map_public_ip_on_launch = true

  depends_on = [aws_internet_gateway.igw-855152ed]
}

provider "aws" {}

resource "aws_instance" "Main"{
  ami = "ami-00dfe2c7ce89a450b"
  instance_type = "t2.micro"

  subnet_id = aws_subnet.tf_test_subnet.subnet-d9d851b2
  private_ip = "172.31.5.250"

  tags = {
    Name = "Web Server"
    Owner = "Dmytro Kolomiiets"
  }
}
