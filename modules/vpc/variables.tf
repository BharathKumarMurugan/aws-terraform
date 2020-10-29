variable "vpc_cidr" {
    default = "11.0.1.0/24"
}

variable "pub_sub_cidr" {
    default = "11.0.1.16/28"
}

variable "pvt_sub_cidr" {
    default = "11.0.1.0/28"
}

variable "az"{
    default ="ap-south-1a"
}

variable "env"{
    default ="dev"
}
variable "appName"{
    default ="Loki"
}

variable "MyIP" {
    default = "27.5.113.138/32"
}
variable "open_cidr"{
    default = "0.0.0.0/0"
}