data "template_file" "policy"{
    template = "${file("${path.module}/policy.json")}"
}

resource "aws_iam_policy" "policy" {
  name = "example_policy"
  path = "/"
  description = "example policy"
  policy = data.template_file.policy.rendered
  
}