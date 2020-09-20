# Import Policy document
data "template_file" "myPolicy" {
  template = "${file("${path.module}/policy.json")}"
}

# Create IAM user
resource "aws_iam_user" "hulk" {
  name = "hulk_iam_user"
  path = "/"
  tags = {
    Name = "Hulk_IAM_user"
  }
}

# IAM user access key
resource "aws_iam_access_key" "hulkManagedUser" {
  user = aws_iam_user.hulk.name
}

# Attach IAM Policy to user
resource "aws_iam_user_policy" "hulkPolicy" {
  name   = "hulk_user_policy"
  user   = aws_iam_user.hulk.name
  policy = data.template_file.myPolicy.rendered
}
