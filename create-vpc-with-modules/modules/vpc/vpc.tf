terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~>3.6"
        }
    }    
}

provider "aws"{
    region = "ap-south-1"
}
resource "aws_vpc" "LokiVPC"{
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true
    enable_dns_support = true
    instance_tenancy = var.tenancy
    tags = {
        Name = var.vpc_name
    }
}
resource "aws_internet_gateway" "LokiIGW"{
    vpc_id = aws_vpc.LokiVPC.id
    tags = {
        Name = var.igw_name
    }
}
resource "aws_subnet" "LokiPubSub"{
    vpc_id = aws_vpc.LokiVPC.id
    cidr_block = var.subnet_cidr
    tags = {
        Name = var.subnet_name
    }
}
resource "aws_route_table" "LokiRT"{
    vpc_id = aws_vpc.LokiVPC.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.LokiIGW.id
    }
    tags = {
        Name = var.rt_name
    }
}
resource "aws_route_table_association" "LokiRT_assoc"{
    route_table_id = aws_route_table.LokiRT.id
    subnet_id = aws_subnet.LokiPubSub.id
    depends_on = [aws_route_table.LokiRT]
}
resource "aws_security_group" "LokiSecGroup"{
    name = var.secgrp_name
    description = "LokiSecGroup"
    vpc_id = aws_vpc.LokiVPC.id
    ingress {
        description = "SSH for me"
        from_port = 22
        to_port = 22
        protocol = "TCP"
        cidr_blocks = ["192.168.0.1/32"]
    }
    ingress {
        description = "HTTP for all"
        from_port = 80
        to_port = 80
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "8080 for all"
        from_port = 8080
        to_port = 8080
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = var.secgrp_name
    }
}
