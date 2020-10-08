variable "launch_config_name" {
  default = "exampleLaunchConfig"
}
variable "ami_id" {
  default = "ami-0cda377a1b884a1bc"
}
variable "instance_type" {
  default = "t2.micro"
}
variable "keyname" {
  default = "thor"
}
variable "placement_grp_name" {
  default = "examplePlacement"
}
variable "autoscaling_grp_name" {
  default = "example_ASG"
}
variable "max" {
  default = 3
}
variable "min" {
  default = 1
}
variable "desired" {
  default = 1
}
variable "subnet_ids" {
  type = list(string)
}
variable "env" {
  default = "dev"
}
