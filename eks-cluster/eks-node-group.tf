resource "aws_eks_node_group" "eks_node" {
  cluster_name    = aws_eks_cluster.aws_eks_mumbai.name
  node_group_name = "eks_node_group"
  node_role_arn   = aws_iam_role.eks_node_group_STS_role.arn
  subnet_ids      = aws_subnet.SteveRogersPubSub1[*].id

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }
  depends_on = [
    aws_iam_role_policy_attachment.EKS_Worker_Node_policy,
    aws_iam_role_policy_attachment.EKS_CNI_policy,
    aws_iam_role_policy_attachment.EKS_Container_Registry_ReadOnly_policy,
  ]
}
