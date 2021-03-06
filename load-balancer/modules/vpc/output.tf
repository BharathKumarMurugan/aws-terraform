output "vpc_id" {
  value = aws_vpc.exampleVPC.id
}
# output "subnet_ids" {
#   value = zipmap(
#     var.azs,
#     coalescelist(aws_subnet.exampleSubnet.*.id),
#   )
#   description = "Map of AZs to Subnet ID"
# }
output "subnet_ids" {
  value = aws_subnet.exampleSubnet.*.id
}
output "security_group_ids" {
  value = aws_security_group.exampleSecGrp.id
}
