output "ec2_pvt_ip" {
  value = aws_instance.example.private_ip
}
output "ec2_pub_ip" {
  value = aws_instance.example.public_ip
}
