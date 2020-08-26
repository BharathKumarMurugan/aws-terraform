output "vpc_id"{
    value = "${aws_vpc.demo_vpc.id}"
}
output "public_subnet"{
    value = ["${aws_subnet.demo_pub_subnet.id}"]
}
output "public_route_table_id"{
    value = ["${aws_route_table.demo_public_rt.id}"]
}
output "public_instance_ip" {
   value = ["${aws_instance.demo_instance.public_ip}"]
}
