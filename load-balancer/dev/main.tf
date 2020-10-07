provider "aws" {
    region = "ap-south-1"
}

# VPC module
module "myVPC" {
    source = "../modules/vpc"
    vpc_name = "ALB_VPC_dev"
    igw_name = "ALB_IGW_dev"
    rt_name = "ALB_RT_dev"
    sec_grp_name = "ALB_secgrp_dev"
    sec_grp_description = "ALB Security Group for dev env"
    vpc_cidr = "10.10.10.0/24"
    subnet_cidr = ["10.10.10.0/28"]
    azs = ["ap-south-1a"]
    env = "dev"
}

# EC2 module
module "myEC2" {
    source = "../modules/ec2"
    ami = "ami-0cda377a1b884a1bc"
    keyname = "thor"
    instance_type = "t2.micro"
    subnet_ids = ["subnet-016ed1656771f9387","subnet-05a85f9384d55fb5f"]
    subnet_id = module.myVPC.subnet_id
    env = "dev"

    depends_on = [module.myVPC]
}
