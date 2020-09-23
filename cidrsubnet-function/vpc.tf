resource "aws_vpc" "testVPC"{
    cidr_block = var.vpc_cidr
    instance_tenancy = "default"
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {
        Name = "testVPC"
    }
}

resource "aws_subnet" "testSubnet" {
    count = 3
    vpc_id = aws_vpc.testVPC.id
    cidr_block = cidrsubnet(var.vpc_cidr,10,count.index)
    tags = {
        Name = "Subnet-${count.index + 1}"
    }
	depends_on = [aws_vpc.testVPC]
}
