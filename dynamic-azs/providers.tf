terraform {
	required_providers {
		aws = {
			source = "hashicorp/aws"
			version = "~>3.6"
		}
	}
}

provider "aws" {
	region = var.region
}
