# VPC
resource "aws_vpc" "hulkvpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support  = true
  enable_dns_hostnames = true
  tags = {
    Name    = "HulkVPC"
    Purpose = "From_terraform"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "hulkigw" {
  vpc_id = aws_vpc.hulkvpc.id 
  tags = {
    Name    = "HulkIGW"
    Purpose = var.purpose_tag
  }
}

# Public Subnet
resource "aws_subnet" "hulkpubsub" {
  vpc_id                  = aws_vpc.hulkvpc.id
  cidr_block              = var.pub_sub_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.az
  tags = {
    Name    = "HulkPubSub"
    Purpose = var.purpose_tag
  }
}

# Private Subnet
resource "aws_subnet" "hulkpvtsub" {
  cidr_block        = var.pvt_sub_cidr
  vpc_id            = aws_vpc.hulkvpc.id
  availability_zone = var.az
  tags = {
    Name    = "HulkPvtSub"
    Purpose = var.purpose_tag
  }
}

# Public Route Table
resource "aws_route_table" "hulkPubRT" {
  vpc_id = aws_vpc.hulkvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.hulkigw.id
  }
  tags = {
    Name    = "HulkPubRT"
    Purpose = var.purpose_tag
  }
}

# Private Route Table
resource "aws_route_table" "hulkPvtRT" {
  vpc_id = aws_vpc.hulkvpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.hulknat.id
  }
  tags = {
    Name    = "HulkPvtRT"
    Purpose = var.purpose_tag
  }
  depends_on = [aws_nat_gateway.hulknat]
}

# Public Route Table Association
resource "aws_route_table_association" "hulkPubRT_assoc" {
  subnet_id      = aws_subnet.hulkpubsub.id
  route_table_id = aws_route_table.hulkPubRT.id
  depends_on = [aws_route_table.hulkPubRT]
}
# Private Route Table Association
resource "aws_route_table_association" "hulkPvtRT_assoc" {
  subnet_id      = aws_subnet.hulkpvtsub.id
  route_table_id = aws_route_table.hulkPvtRT.id
  depends_on = [aws_route_table.hulkPvtRT]
}

# Elastic IP for NAT
resource "aws_eip" "hulkeip"{
    vpc = true
    tags = {
        Name = "HulkEIP"
        Purpose = var.purpose_tag
    }
}

# NAT Gateway
resource "aws_nat_gateway" "hulknat"{
    allocation_id = aws_eip.hulkeip.id
    subnet_id = aws_subnet.hulkpubsub.id
    tags = {
        Name = "HulkNat"
        Purpose = var.purpose_tag
    }
    depends_on = [aws_eip.hulkeip]
}

# Security Group
resource "aws_security_group" "hulksecgrp"{
    name = "HulkSecGroup"
    description = "Hulk Security Group"
    vpc_id = aws_vpc.hulkvpc.id
    ingress {
        description = "SSH for me"
        from_port = 22
        to_port = 22
        protocol = "TCP"
        cidr_blocks = [var.MyIP]
    }
    ingress {
        description = "HTTP for all"
        from_port = 80
        to_port = 80
        protocol = "TCP"
        cidr_blocks = [var.open_cidr]
    }
    ingress {
        description = "8080 for all"
        from_port = 8080
        to_port = 8080
        protocol = "TCP"
        cidr_blocks = [var.open_cidr]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [var.open_cidr]
    }
    tags = {
        Name = "HulkSecGroup"
        Purpose = var.purpose_tag
    }
}