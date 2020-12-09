terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~>3.10"
        }
    }
}
provider "aws" {
    region = "ap-south-1"
}

resource "aws_ssm_document" "example" {
    name = "my-test-ssm-from-tf"
    document_type = "Command"
    target_type = "/AWS::EC2::Instance"
    content = <<DOC
    {
  "schemaVersion": "1.2",
  "description": "Create a directory if not exists.",
  "parameters": {
    "executionTimeout": {
      "type": "String",
      "default": "3600"
    }
  },
  "runtimeConfig": {
    "aws:runShellScript": {
      "properties": [
        {
          "id": "0.aws:runShellScript",
          "runCommand": [
            "sudo mkdir -p /bharathkumar",
            "sudo echo \"This is a sample file\" >> /bharathkumar/bharathkumar.txt"
          ]
        }
      ]
    }
  }
}
    DOC
    tags = {
        Name = "my-test-ssm-from-tf"
        Env = "dev"
    }
}