resource "aws_instance" "example" {
  # count = length(var.subnet_ids)
  instance_type = var.instance_type
  ami           = var.ami
  # subnet_id = element(var.subnet_ids, count.index)
  subnet_id = var.subnet_ids
  user_data = file("~/practice/aws-terraform/load-balancer/modules/ec2/install_apache.sh")
  tags = {
    Name        = "ALB_ins"
    Environment = var.env
  }
}
