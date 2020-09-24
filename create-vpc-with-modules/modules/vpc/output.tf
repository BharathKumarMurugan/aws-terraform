output "vpc_id" {
    value = "${aws_vpc.LokiVPC.id}"
}
output "subnet_id" {
	value = aws_subnet.LokiPubSub.id
}
