//DevOps practice

provider "AWS" {
    access_key = "AKIAU7YO3OD34EVNO3V6"
    secret_key = "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"
    region = "us-east-2"
}

resource "aws_instance" "Jenkins_Serv" {
    ami = "ami-00399ec92321828f5"
    instance_type = "t2.micro"
}