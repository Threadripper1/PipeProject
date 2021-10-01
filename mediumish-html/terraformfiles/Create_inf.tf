//DevOps practice

provider "aws" {
    access_key = "AKIAU7YO3OD3TN4QP2UX"
    secret_key = "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"
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
