terraform {
	required_providers{
		aws = {
			source = "hashicorp/aws"
			version = "~>3.6"
		}
	}
}

provider "aws"{
	region = "ap-south-1"
}

variable "env"{
	default = "stage"
}
resource "aws_vpc" "example"{
	count = var.env=="dev"?1:0
	cidr_block = "11.0.0.0/16"
	enable_dns_hostnames = true
	enable_dns_support = true
	tags = {
		Name = "exampleVPC"
	}
}
