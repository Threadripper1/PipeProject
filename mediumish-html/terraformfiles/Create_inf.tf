//DevOps practice

provider "aws" {
    access_key = "AKIAU7YO3OD3TN4QP2UX"
    secret_key = "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"
    region = "us-east-2"
}

resource "aws_instance" "MainServer" {
    ami = "ami-00399ec92321828f5"
    instance_type = "t2.micro"
}
