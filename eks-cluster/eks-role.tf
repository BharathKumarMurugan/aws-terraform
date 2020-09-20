# Import cluster role file
data "template_file" "eks_cluster_policy" {
  template = "${file("${path.module}/cluster-role.json")}"
}

# create eks cluster role
resource "aws_iam_role" "eks_cluster_STS_role" {
  name               = "eks_cluster_STS_role"
  assume_role_policy = data.template_file.eks_cluster_policy.rendered
  tags = {
    Name = "eks_cluster_STS_role"
  }
}
resource "aws_iam_role_policy_attachment" "myAmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_STS_role.name
}
resource "aws_iam_role_policy_attachment" "myAmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks_cluster_STS_role.name
}




# resource "aws_security_group_rule" "myCluster-ingress-node-https" {
#   description              = "Allow pods to communicate with the cluster API Server"
#   from_port                = 443
#   protocol                 = "tcp"
#   security_group_id        = aws_security_group.eks_cluster_STS_role.id
#   source_security_group_id = aws_security_group.eks_node_group_STS_role.id
#   to_port                  = 443
#   type                     = "ingress"
# }