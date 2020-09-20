data "template_file" "eks_node_group_policy"{
    template = "${file("${path.module}/node-group-role.json")}"
}

resource "aws_iam_role" "eks_node_group_STS_role"{
    name = "eks_node_group_STS_role"
    assume_role_policy = data.template_file.eks_node_group_policy.rendered
}

resource "aws_iam_role_policy_attachment" "EKS_Worker_Node_policy"{
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    role = aws_iam_role.eks_node_group_STS_role.name
}
resource "aws_iam_role_policy_attachment" "EKS_CNI_policy"{
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    role = aws_iam_role.eks_node_group_STS_role.name
}
resource "aws_iam_role_policy_attachment" "EKS_Container_Registry_ReadOnly_policy"{
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    role = aws_iam_role.eks_node_group_STS_role.name
}