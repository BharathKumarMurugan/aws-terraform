variable "region" {
	default = "us-east-1"
}

variable "vpc_cidr" {
	default = "192.168.0.0/16"
}

variable "subnet_cidr" {
	type = list
	default = ["192.168.0.0/28","192.168.1.0/28","192.168.2.0/28"]
}

data "aws_availability_zones" "available" {}
