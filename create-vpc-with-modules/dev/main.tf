provider "aws"{
    region = "ap-south-1"
}
module "myVPC" {
    source = "../modules/vpc"
    vpc_cidr = "192.168.1.0/24"
    subnet_cidr = "192.168.1.0/28"
    vpc_name = "LokiVPC-dev"
    subnet_name = "LokiPubSub-dev"
    igw_name = "LokiIGW-dev"
    rt_name = "LokiRT-dev"
    secgrp_name = "LokiSecGroup-dev"
    tenancy = "default"
    # vpc_id = module.myVPC.vpc_id
}
