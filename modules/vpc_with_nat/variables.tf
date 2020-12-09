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

variable "purpose_tag"{
    default ="From_terraform"
}

variable "MyIP" {
    default = "192.168.1.10/32"
}
variable "open_cidr"{
    default = "0.0.0.0/0"
}