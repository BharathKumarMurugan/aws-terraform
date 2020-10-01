# Private Tag
resource "aws_s3_bucket" "bucket" {
    bucket = var.bucket_name
    acl = "private"
    tags = {
        Name = var.bucket_name
        Environment = "Dev"
    }
}

# Static Website Hosting
resource "aws_s3_bucket" "bucket" {
    bucket = var.bucket_name
    acl = "public-read"

    website {
        index_document = "index.html"
        error_document = "error.html"

        routing_rules = <<EOF
        [{
            "Condition": {
                "KeyPrefixEquals": "docs/"
            },
            "Redirect": {
                "ReplaceKeyPrefixWith": "documents/"
            }
        }]
        EOF
    }
    tags = {
        Name = var.bucket_name
        Environment = "Dev"
    }
}

# Using CORS
#resource "aws_s3_bucket" "bucket" {
    bucket = "s3-website-test-from-terraform.hashicorp.com"
    acl    = "public-read"

    cors_rule {
        allowed_headers = ["*"]
        allowed_methods = ["PUT", "POST"]
        allowed_origins = ["https://s3-website-test-from-terraform.hashicorp.com"]
        expose_headers = ["ETag"]
        max_age_seconds = 3000
    }
    tags = {
        Name = "s3-website-test-from-terraform.hashicorp.com"
        Environment = "Dev"
    }
}

# Versioning
resource "aws_s3_bucket" "bucket" {
    bucket = var.bucket_name
    acl = "private"
    versioning {
        enabled = true
    }
    tags = {
        Name = var.bucket_name
        Environment = "Dev"
    }
}

# Object Lifecycle
resource "aws_s3_bucket" "bucket" {
    bucket = var.bucket_name
    acl = "private"

    lifecycle_rule {
        id = "log"
        enabled = true

        prefix = "log/"

        tags = {
            "rule" = "log"
            "autoclean" = "true"
        }
        transition {
            days = 30
            storage_class = "STANDARD_IA"
        }
        transition {
            days = 60
            storage_class = "GLACIER"
        }
    }
}
