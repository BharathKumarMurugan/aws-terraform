terraform {
    required_providers {
        aws = {
            "source" = "hashicorp/aws"
        }
    }
}
provider "aws" {
    profile = "default"
    region = "ap-south-1"
}
resource "aws_vpc" "demo_vpc"{
    cidr_block = var.vpc_cidr
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
        Purpose = var.ec2_tag
	Name = "demo_vpc"
    }
}
resource "aws_internet_gateway" "demo_igw"{
    vpc_id = aws_vpc.demo_vpc.id
    tags = {
        Name = "demo_igw"
	Purpose = var.ec2_tag
    }
}
resource "aws_subnet" "demo_pub_subnet"{
    vpc_id = aws_vpc.demo_vpc.id
    cidr_block = var.pub_subnet_cidr
    map_public_ip_on_launch = true
    availability_zone = var.az
    tags = {
	Name = "demo_pub_subnet"
        Purpose = var.ec2_tag
    }
}
resource "aws_route_table" "demo_public_rt"{
    vpc_id = aws_vpc.demo_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.demo_igw.id
    }
    tags = {
	Name = "demo_public_rt"
        Purpose = var.ec2_tag
    }
}
resource "aws_route_table_association" "demo_pub_rt_assoc"{
    subnet_id = aws_subnet.demo_pub_subnet.id
    route_table_id = aws_route_table.demo_public_rt.id
}
resource "aws_security_group" "demo_sec_group"{
    name = "sec_group"
    vpc_id = aws_vpc.demo_vpc.id
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["27.5.64.51/32"]
    }
    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
	Name = "demo_sec_group"
        Purpose = var.ec2_tag
    }
}
resource "aws_instance" "demo_instance"{
	ami = var.ec2_ami
	instance_type = var.ec2_type
	subnet_id = aws_subnet.demo_pub_subnet.id
	vpc_security_group_ids = [aws_security_group.demo_sec_group.id]
	key_name = "kube-client"
	monitoring = true
	tags = {
		Name = "demo_instance"
		Purpose = var.ec2_tag
		OS = "ubuntu-18.04"
		Region = "mumbai"
	}
}
