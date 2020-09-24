data "template_file" "myPolicy"{
    template = file("${path.module}/policy.json")
}

resource "aws_iam_policy" "Unused_EIP_Policy"{
    name = "Unused_EIP_Policy"
    path = "/"
    description = "Unused EIP Policy for Lambda"
    policy = data.template_file.myPolicy.rendered
}

data "template_file" "myRole"{
    template = file("${path.module}/role.json")
}

resource "aws_iam_role" "Unused_EIP_Role"{
    name = "Unused_EIP_Role"
    assume_role_policy = data.template_file.myRole.rendered
}

resource "aws_iam_policy_attachment" "Unused_EIP_Policy_Attach"{
    name = "Unused_EIP_Policy_Attach"
    roles = [aws_iam_role.Unused_EIP_Role.name]
    policy_arn = aws_iam_policy.Unused_EIP_Policy.arn
}
