terraform {
  required_provider {
      aws = {
          source = "hashicorp/aws"
          version = "~>3.15"
      }
  }
}
provider "aws" {
  region = "us-east-1"
  profile = "value"
}