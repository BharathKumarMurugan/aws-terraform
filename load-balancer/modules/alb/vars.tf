variable "alb_name" {}
variable "security_group_ids" {
  type = list(string)
}
variable "subnet_ids" {
  type = list(string)
}
variable "env" {
  default = "dev"
}
variable "target_grp_name" {}
variable "vpc_id" {}
