terraform{
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~>3.12"
        }
    }
}
provider "aws"{
    region = "us-east-1"
    profile = "default"
}