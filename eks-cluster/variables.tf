variable "vpc_cidr" {
  default = "11.11.0.0/20"
}
variable "pub_sub_cidr" {
    type = list
  default = ["11.11.0.0/24","11.11.1.0/24"]
}

variable "myIP" {
  default = "192.168.1.0/32"
}
variable "ekstag"{
    default = "EKS/mumbai"
}
variable "az"{
    default =["ap-south-1b", "ap-south-1c"]
}
variable "open_cidr"{
    default = "0.0.0.0/0"
}