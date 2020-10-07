output "instance_public_ip" {
    value = zipmap(
        aws_instance.example.*.tags.Name,
        coalescelist(aws_instance.example.*.public_ip),
    )
    description = "Map of Instances to Public IPs"
}
output "instance_private_ip" {
    value = zipmap(
        aws_instance.example.*.tags.Name,
        coalescelist(aws_instance.example.*.private_ip),
    )
    description = "Map of Instances to Private IPs"
}
