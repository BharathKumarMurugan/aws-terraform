variable "vpc_name"{}
variable "igw_name"{}
variable "rt_name"{}
variable "sec_grp_name"{}
variable "sec_grp_description"{}
variable "vpc_cidr"{
    default = "10.10.10.0/24"
}
variable "subnet_cidr"{
    type = list
    default = ["10.10.10.0/28","10.10.10.16/28","10.10.10.32/28"]
}
variable "azs"{
    type = list
    default = ["ap-south-1a", "ap-south-1b","ap-south-1c"]
}
variable "env"{
    default = "dev"
}
