output "vpc_id" {
    value = aws_vpc.examplevpc.id
}
output "public_subnet" {
    value = aws_subnet.examplepubsub.id
}
output "pvt_subnet" {
    value = aws_subnet.examplepvtsub.id
}