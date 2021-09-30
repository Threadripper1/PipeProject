//DevOps practice

provider "aws" {
    access_key = "AKIAU7YO3OD35DBWL3JJ"
    secret_key = "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"
    region = "us-east-2"
}

resource "aws_instance" "MainServer" {
    ami = "ami-00399ec92321828f5"
    instance_type = "t2.micro"
}