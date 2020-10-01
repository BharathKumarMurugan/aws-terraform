variable "vpc_cidr" {
    default = "192.168.1.0/24"
}
variable "subnet_cidr"{
    default = "192.168.1.0/28"
}
data "aws_availability_zones" "available" {}

variable "tenancy" {
    default = "default"
}
variable "vpc_name"{
    default = "LokiVPC"
}
variable "subnet_name"{
    default = "LokiPubSub"
}
variable "igw_name"{
    default = "LokiIGW"
}
variable "rt_name"{
    default = "LokiRT"
}
variable "secgrp_name"{
    default = "LokiSecGroup"
}

