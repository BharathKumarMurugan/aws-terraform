variable "vpc_cidr" {
    default = "172.1.0.0/16"
}
variable "pub_subnet_cidr" {
    default = "172.1.0.0/28"
}
variable "az" {
    default = "ap-south-1a"
}
variable "keypair_path"{
    default = "./kube-client.pub"
}
variable "ec2_ami" {
    default = "ami-02b5fbc2cb28b77b8"
}
variable "ec2_type" {
    default = "t2.micro"
}
variable "ec2_tag"{
    default = "Learning"
}
