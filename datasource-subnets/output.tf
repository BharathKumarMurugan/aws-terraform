output "subnetList" {
    value = {
        for subnet, details in data.aws_subnet.example : subnet => ({"id" = details.id, "name" = details.tags.Name, "cidr" = details.cidr_block, "az" = details.availability_zone})
    }
}