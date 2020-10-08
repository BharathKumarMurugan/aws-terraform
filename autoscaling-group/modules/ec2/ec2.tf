resource "aws_instance" "example" {
  count         = length(var.subnet_ids)
  instance_type = var.instance_type
  ami           = var.ami
  subnet_id     = element(var.subnet_ids, count.index)
  # subnet_id              = var.subnet_ids
  vpc_security_group_ids = var.security_group_ids
  user_data              = file("./install_apache.sh")
  tags = {
    Name        = "ALB_ins-${count.index + 1}"
    Environment = var.env
  }
}
