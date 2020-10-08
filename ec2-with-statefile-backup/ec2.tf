terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.8"
    }
  }
}
provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "example" {
  instance_type = "t2.micro"
  ami           = "ami-1234"
  subnet_id     = "subnet-1234"
  key_name      = "keyname"
  tags = {
    Name = "exmaple-Instance"
  }
}
