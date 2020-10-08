variable "vpc_cidr" {
  default = "10.10.10.0/24"
}
variable "subnet_cidr" {
  type    = list
  default = ["10.10.10.0/28", "10.10.10.16/28"]
}
variable "azs" {
  type    = list
  default = ["ap-south-1a", "ap-south-1b"]
}
variable "ami" {
  default = "ami-0cda377a1b884a1bc"
}
variable "keyname" {
  default = "thor"
}
variable "instance_type" {
  default = "t2.micro"
}
variable "vpc_cidr" {
  default = ""
}
variable "vpc_cidr" {
  default = ""
}
variable "env" {
  default = "dev"
}
