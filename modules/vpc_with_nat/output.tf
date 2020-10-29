output "vpc_id" {
    value = "${aws_vpc.hulkvpc.id}"
}
output "public_subnet" {
    value = "${aws_subnet.hulkpubsub.id}"
}
output "pvt_subnet" {
    value = "${aws_subnet.hulkpvtsub.id}"
}
output "eip" {
    value = "${aws_eip.hulkeip.id}"
}