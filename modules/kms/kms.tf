resource "aws_kms_key" "example" {
  description = "sample KMS key"
  enable_key_rotation = true
  tags = {
      Name = "sample-kms-key"
      Purpose = "testing"
  } 
}

resource "aws_kms_alias" "example" {
  name = "alias/sample-kms-key"
  target_key_id = aws_kms_key.example.key_id
}

output "kms_key" {
  value = aws_kms_key.example
}