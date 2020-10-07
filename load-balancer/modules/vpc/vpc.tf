resource "aws_vpc" "exampleVPC"{
    instance_tenancy = "default"
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {
        Name = var.vpc_name
        Environment = var.env
    }
}
resource "aws_internet_gateway" "exampleIGW"{
    vpc_id = aws_vpc.exampleVPC.id
    tags = {
        Name = var.igw_name
        Environment = var.env
    }
}
resource "aws_subnet" "exampleSubnet"{
    vpc_id = aws_vpc.exampleVPC.id
    count = length(var.subnet_cidr)
    cidr_block = element(var.subnet_cidr, count.index)
    availability_zone = element(var.azs, count.index)
    map_public_ip_on_launch = true
    tags = {
        Name = "Subnet-${count.index + 1}"
        Environment = var.env
    }
}
resource "aws_route_table" "exampleRT"{
    vpc_id = aws_vpc.exampleVPC.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.exampleIGW.id
    }
    tags = {
        Name = var.rt_name
        Environment = var.env
    }
}
resource "aws_route_table_association" "exampleRTassoc"{
    count = length(var.subnet_cidr)
    route_table_id = aws_route_table.exampleRT.id
    subnet_id = element(aws_subnet.exampleSubnet.*.id, count.index)
}
resource "aws_security_group" "exampleSecGrp" {
    name = var.sec_grp_name
    description = var.sec_grp_description
    vpc_id = aws_vpc.exampleVPC.id
    ingress {
        description = "SSH for me"
        from_port = 22
        to_port = 22
        protocol = "TCP"
        cidr_blocks = ["27.5.121.200/32"]
    }
    ingress {
        description = "HTTP to all"
        from_port = 80
        to_port = 80
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
        Name = var.sec_grp_name
        Environment = var.env
    }
}
