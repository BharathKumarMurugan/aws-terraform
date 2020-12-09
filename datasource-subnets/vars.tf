data "aws_subnet_ids" "example" {
  vpc_id = "vpc-12345"
}

data "aws_subnet" "example" {
  for_each = data.aws_subnet_ids.example.ids
  id = each.value
}