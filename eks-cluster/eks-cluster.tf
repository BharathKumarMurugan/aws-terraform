resource "aws_eks_cluster" "aws_eks_mumbai" {
  name     = "aws_eks_mumbai"
  role_arn = aws_iam_role.eks_cluster_STS_role.arn
  vpc_config {
    subnet_ids =aws_subnet.SteveRogersPubSub1[*].id
  }
  tags = {
    Name    = "SteveRogersRT"
    Purpose = var.ekstag
  }
}
