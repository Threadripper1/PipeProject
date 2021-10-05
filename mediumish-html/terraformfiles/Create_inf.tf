//DevOps practice

terraform {
  required_providers {
    aws = {
        source  = "hashicorp/aws"
        version = "~> 3.0"
    }
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCsWIdKqiz2IpMytamaBbVpqlRu72A+9A/6oUxB03iv4R3VNhqzKl+JfGOTf7WAyMmhA0GiQEzi9PGJ2RsgY4bxnaEpoJrCnHjQLvmgZ4h/gX4HjzIwoHxGE1cn4UV9P/jocS67Jm3O8t1jgSVU561eXLZjsh6lbZBZFsJ15+VJ7liQizh9aoTGcIkfLv0EO2OjcFnvpB9WQD0BeKokGUKULJ60J8flPS2IF/CF3YTeZI7Hs9kDqCtfXbgeWD6hWr91UoPli9KaDHCPUocnfYrPbT/t2M1IYj+QATKlFLEmXiLFjgZCtU8JqBoOUi6pcwD18+/yWq69To22b/qOQKP/a6Bh7KizvkFB67TfN7RzyCKFFFXWeQOkzP/16n28s8EC2UYWPR6l+azF3FWYNeN5MDExhe7u7e6JqnMeXLhe+KfaBk83hTPOLzSGCGU3cRL4PiiAJmKrvsBgojuQBAXCONV9sPvgrcJ6h6hillgALMm2B1T2JKRMHqqRgmEQkHc= ubuntu@ip-172-31-10-204"
  }

provider "aws" {}

resource "aws_instance" "WebServer"{
  ami = "ami-00399ec92321828f5"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.deployer.key_name

  user_data = file("/var/lib/jenkins/ssh_connection.sh")

  tags = {
    Name = "Web Server"
    Owner = "Dmytro Kolomiiets"
  }
}
