provider "aws" {
  region = "ap-south-1"
}

# VPC module
module "myVPC" {
  source              = "./modules/vpc"
  vpc_name            = "ALB_VPC_${var.env}"
  igw_name            = "ALB_IGW_${var.env}"
  rt_name             = "ALB_RT_${var.env}"
  sec_grp_name        = "ALB_secgrp_${var.env}"
  sec_grp_description = "ALB Security Group for dev env"
  vpc_cidr            = var.vpc_cidr
  subnet_cidr         = [var.subnet_cidr]
  azs                 = [var.azs]
  env                 = var.env
}

# EC2 module
module "myEC2" {
  source        = "./modules/ec2"
  ami           = var.ami_id
  keyname       = var.keyname
  instance_type = var.instance_type
  # subnet_ids = ["subnet-016ed1656771f9387","subnet-05a85f9384d55fb5f"]
  subnet_ids         = [module.myVPC.subnet_ids[0]]
  security_group_ids = [module.myVPC.security_group_ids]
  env                = var.env

  depends_on = [module.myVPC]
}

# Application Load Balancer
module "myALB" {
  source             = "./modules/alb"
  alb_name           = "ALB-${var.env}"
  security_group_ids = [module.myVPC.security_group_ids]
  subnet_ids         = module.myVPC.subnet_ids
  target_grp_name    = "ALB-target-grp-${var.env}"
  vpc_id             = module.myVPC.vpc_id
  env                = var.env

  depends_on = [module.myVPC]
}

# AutoScaling Group
module "myASG" {
  source               = "./modules/asg"
  launch_config_name   = "exampleLaunchConfig"
  ami_id               = var.ami_id
  instance_type        = var.instance_type
  keyname              = var.keyname
  placement_grp_name   = "examplePlacement"
  autoscaling_grp_name = "example_ASG"
  max                  = 5
  min                  = 1
  desired              = 1
  subnet_ids           = module.myVPC.subnet_ids
  env                  = var.env
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
