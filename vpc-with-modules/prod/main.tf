provider "aws"{
    region = "ap-south-1"
}
module "myVPC" {
    source = "../modules/vpc"
    vpc_cidr = "192.168.2.0/24"
    subnet_cidr = "192.168.2.16/28"
    vpc_name = "LokiVPC-prod"
    subnet_name = "LokiPubSub-prod"
    igw_name = "LokiIGW-prod"
    rt_name = "LokiRT-prod"
    secgrp_name = "LokiSecGroup-prod"
    tenancy = "default"
    # vpc_id = module.myVPC.vpc_id
}
