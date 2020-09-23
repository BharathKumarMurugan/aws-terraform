resource "aws_vpc" "exampleVPC" {
	cidr_block = var.vpc_cidr
	enable_dns_hostnames = true
	instance_tenancy = "default"
	enable_dns_support = true
	tags = {
		Name = "exampleVPC"
	}
}

resource "aws_subnet" "exampleSubent"{
	count = length(data.aws_availability_zones.available.names) # dynamically fetch the number of AZs available in the given region
	vpc_id = aws_vpc.exampleVPC.id
	# cidr_block = element(var.subnet_cidr, count.index) # fetch element from the list one by one
	cidr_block = cidrsubnet(var.vpc_cidr, 12, count.index)
	tags = {
		Name = "Subnet-${count.index + 1}"
	}
}
