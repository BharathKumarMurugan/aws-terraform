# VPC
resource "aws_vpc" "examplevpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support  = true
  enable_dns_hostnames = true
  tags = {
    Name    = "${var.appName}-VPC"
    Env = var.env
  }
}

# Internet Gateway
resource "aws_internet_gateway" "exampleigw" {
  vpc_id = aws_vpc.examplevpc.id 
  tags = {
    Name    = "${var.appName}-IGW"
    Env = var.env
  }
}

# Public Subnet
resource "aws_subnet" "examplepubsub" {
  vpc_id                  = aws_vpc.examplevpc.id
  cidr_block              = var.pub_sub_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.az
  tags = {
    Name    = "${var.appName}-PubSub"
    Env = var.env
  }
}

# Private Subnet
resource "aws_subnet" "examplepvtsub" {
  cidr_block        = var.pvt_sub_cidr
  vpc_id            = aws_vpc.examplevpc.id
  availability_zone = var.az
  tags = {
    Name    = "${var.appName}-PvtSub"
    Env = var.env
  }
}

# Public Route Table
resource "aws_route_table" "examplePubRT" {
  vpc_id = aws_vpc.examplevpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.exampleigw.id
  }
  tags = {
    Name    = "${var.appName}-PubRT"
    Env = var.env
  }
}

# Private Route Table
resource "aws_route_table" "examplePvtRT" {
  vpc_id = aws_vpc.examplevpc.id
  tags = {
    Name    = "${var.appName}-PvtRT"
    Env = var.env
  }
}

# Public Route Table Association
resource "aws_route_table_association" "examplePubRT_assoc" {
  subnet_id      = aws_subnet.examplepubsub.id
  route_table_id = aws_route_table.examplePubRT.id
  depends_on = [aws_route_table.examplePubRT]
}
# Private Route Table Association
resource "aws_route_table_association" "examplePvtRT_assoc" {
  subnet_id      = aws_subnet.examplepvtsub.id
  route_table_id = aws_route_table.examplePvtRT.id
  depends_on = [aws_route_table.examplePvtRT]
}