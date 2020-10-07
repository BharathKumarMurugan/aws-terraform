variable "ami" {}
variable "keyname" {
  default = "thor"
}
variable "env" {
  default = "dev"
}
variable "instance_type" {}
# variable "subnet_ids"{
#     type = list
#     default =  [
#       "subnet-016ed1656771f9387",
#       "subnet-05a85f9384d55fb5f"
#     ]

# }
variable "subnet_ids" {}
variable "security_group_ids" {
  type = list(string)
}
