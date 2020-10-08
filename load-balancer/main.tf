provider "aws" {
  region = "ap-south-1"
}

# VPC module
module "myVPC" {
  source              = "./modules/vpc"
  vpc_name            = "ALB_VPC_dev"
  igw_name            = "ALB_IGW_dev"
  rt_name             = "ALB_RT_dev"
  sec_grp_name        = "ALB_secgrp_dev"
  sec_grp_description = "ALB Security Group for dev env"
  vpc_cidr            = "10.10.10.0/24"
  subnet_cidr         = ["10.10.10.0/28", "10.10.10.16/28"]
  azs                 = ["ap-south-1a", "ap-south-1b"]
  env                 = "dev"
}

# EC2 module
module "myEC2" {
  source        = "./modules/ec2"
  ami           = "ami-0cda377a1b884a1bc"
  keyname       = "thor"
  instance_type = "t2.micro"
  # subnet_ids = ["subnet-016ed1656771f9387","subnet-05a85f9384d55fb5f"]
  subnet_ids         = [module.myVPC.subnet_ids[0]]
  security_group_ids = [module.myVPC.security_group_ids]
  env                = "dev"

  depends_on = [module.myVPC]
}

# Application Load Balancer
module "myALB" {
  source             = "./modules/alb"
  alb_name           = "ALB-dev"
  security_group_ids = [module.myVPC.security_group_ids]
  subnet_ids         = module.myVPC.subnet_ids
  target_grp_name    = "ALB-target-grp-dev"
  vpc_id             = module.myVPC.vpc_id
  env                = "dev"

  depends_on = [module.myVPC, module.myEC2]
}

output "subnetID_output_from_module" {
  value = module.myVPC.*.subnet_ids
}
output "PublicIP_output_from_module" {
  value = module.myEC2.*.ins_pub_ip
}
output "SecGrpID_output_from_module" {
  value = module.myVPC.*.security_group_ids
}
output "LB_dns_name" {
  value = module.myALB.alb_dns_name
}
