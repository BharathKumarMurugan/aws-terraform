# VPC
resource "aws_vpc" "SteveRogersVPC" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"
  tags = {
    Name    = "SteveRogersVPC"
    Purpose = var.ekstag
  }
}

# Internet Gateway
resource "aws_internet_gateway" "SteveRogersIGW" {
  vpc_id = aws_vpc.SteveRogersVPC.id
  tags = {
    Name    = "SteveRogersIGW"
    Purpose = var.ekstag
  }
}

# Public Subnets
resource "aws_subnet" "SteveRogersPubSub1" {
  count                   = length(var.pub_sub_cidr)
  vpc_id                  = aws_vpc.SteveRogersVPC.id
  availability_zone       = var.az[count.index]
  cidr_block              = var.pub_sub_cidr[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name    = "SteveRogersPubSub1"
    Purpose = var.ekstag
  }
}

# Route Table
resource "aws_route_table" "SteveRogersRT" {
  vpc_id = aws_vpc.SteveRogersVPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.SteveRogersIGW.id
  }
  tags = {
    Name    = "SteveRogersRT"
    Purpose = var.ekstag
  }
}

# Route Table Association
resource "aws_route_table_association" "SteveRogersRTassoc" {
  count          = length(var.pub_sub_cidr)
  subnet_id      = element(aws_subnet.SteveRogersPubSub1.*.id, count.index)
  route_table_id = aws_route_table.SteveRogersRT.id
  depends_on     = [aws_route_table.SteveRogersRT]
}

# Security Group
resource "aws_security_group" "SteveRogersSecGroup" {
  vpc_id      = aws_vpc.SteveRogersVPC.id
  name        = "SteveRogersSecGroup"
  description = "SteveRogersSecGroup"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.myIP]
    description = "SSH from my IP"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.open_cidr]
  }
  tags = {
    Name    = "SteveRogersSecGroup"
    Purpose = var.ekstag
  }
}
