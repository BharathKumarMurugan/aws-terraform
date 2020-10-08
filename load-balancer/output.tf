output "subnetID_output_from_module" {
  value = module.myVPC.*.subnet_ids
}
output "PublicIP_output_from_module" {
  value = module.myEC2.*.ins_pub_ip
}
output "SecGrpID_output_from_module" {
  value = module.myVPC.*.security_group_ids
}
output "LB_dns_name" {
  value = module.myALB.alb_dns_name
}
