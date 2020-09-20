resource "aws_security_group" "EKS_sec_group" {
  name        = "sampleekssecuritygroup"
  description = "Security group for all nodes in the cluster"
  vpc_id      = aws_vpc.SteveRogersVPC.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "EKS_sec_group"
    Purpose = var.ekstag
  }
}

resource "aws_security_group_rule" "node-ingress" {
  description              = "Allow node to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.EKS_sec_group.id
  source_security_group_id = aws_security_group.EKS_sec_group.id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "master-to-nodes" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control      plane"
  from_port                = 1025
  protocol                 = "tcp"
  security_group_id        = aws_security_group.EKS_sec_group.id
  source_security_group_id = aws_security_group.EKS_sec_group.id
  to_port                  = 65535
  type                     = "ingress"
}
