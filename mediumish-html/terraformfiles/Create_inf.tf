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
  ami = "ami-00399ec92321828f5"
  instance_type = "t2.micro"

  user_data = file("/var/lib/jenkins/ssh_connection.sh")

  tags = {
    Name = "Web Server"
    Owner = "Dmytro Kolomiiets"
  }
}
