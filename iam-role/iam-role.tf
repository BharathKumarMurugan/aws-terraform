data "template_file" "role_policy"{
    template = "${file("${path.module}/policy.json")}"
}

resource "aws_iam_role" "roleSTS"{
    name = "roleSTS"
    assume_role_policy = data.template_file.role_policy.rendered
    tags = {
        Name = "roleSTS"
    }
}