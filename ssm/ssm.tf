# --------------------------------------------------------
# Varibales
# --------------------------------------------------------
variable "aws_region" {
  description = "AWS region used to deploy AWS resources"
  default     = "us-east-1"
}

variable "appName" {
  default = "Loki"
}
variable "vpc_cidr" {
  default = "11.0.1.0/24"
}
variable "pub_sub_cidr" {
  default = "11.0.1.16/28"
}
variable "pvt_sub_cidr" {
  default = "11.0.1.0/28"
}
variable "MyIP" {
  default = "27.5.113.138/32"
}
variable "az" {
  default = "us-east-1a"
}


variable "root_block_device" {
  default = {
    type = "gp2",
    size = "10"
  }
}
variable "managed_policies" {
  default = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
  ]
}
variable "instance_type" {
  default = "t2.small"
}

variable "vpc_endpoints" {
  default = [
    "com.amazonaws.us-east-1.ssm",
    "com.amazonaws.us-east-1.ec2messages",
    "com.amazonaws.us-east-1.ec2",
    "com.amazonaws.us-east-1.ssmmessages"
  ]
}


# --------------------------------------------------------
# Modules
# --------------------------------------------------------
module "myVPC" {
  source = "../modules/vpc"
  vpc_cidr = var.vpc_cidr
  pub_sub_cidr = var.pub_sub_cidr
  pvt_sub_cidr = var.pvt_sub_cidr
  MyIP = var.MyIP
  az = var.az
  env = "dev"
  appName = var.appName
  open_cidr = "0.0.0.0/0"
}


# Key Pairs
resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "key_pair" {
  key_name   = "${var.appName}-key"
  public_key = tls_private_key.private_key.public_key_openssh
}

# Store keys in SSM Parameter Store
resource "aws_ssm_parameter" "private_key_ssm_param" {
  name        = "/${var.appName}/private-key"
  description = "Private Key"
  type        = "SecureString"
  value       = tls_private_key.private_key.private_key_pem
}
resource "aws_ssm_parameter" "public_key_ssm_param" {
  name        = "/${var.appName}/public-key"
  description = "Public Key"
  type        = "SecureString"
  value       = tls_private_key.private_key.public_key_pem
}
resource "aws_ssm_parameter" "public_key_openssh_ssm_param" {
  name        = "/${var.appName}/public-key-openssh"
  description = "Public Key in openssh format"
  type        = "SecureString"
  value       = tls_private_key.private_key.public_key_openssh
}

# Security Groups
resource "aws_security_group" "bastion_sg" {
  name        = "${var.appName}-bastion-sg"
  description = "Security Group for Bastion EC2 instance"
  vpc_id      = module.myVPC.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.MyIP]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "private_sg" {
  name        = "${var.appName}-private-sg"
  description = "Security Group for Private EC2 instance"
  vpc_id      = module.myVPC.vpc_id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "endpoint_sg" {
  name        = "${var.appName}-endpoint-sg"
  description = "Security Group for VPC Endpoints"
  vpc_id      = module.myVPC.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# IAM Resources
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "${var.appName}-ec2-role"
  path = "/"
  role = aws_iam_role.ec2_role.name
}
resource "aws_iam_role" "ec2_role" {
  name               = "${var.appName}-ec2-role"
  path               = "/"
  description        = "Role assigned to EC2 Instance"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
}
resource "aws_iam_role_policy_attachment" "managed_policies" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = var.managed_policies[count.index]
  count      = length(var.managed_policies)
}
resource "aws_iam_policy" "endpoints_s3_policy" {
  name   = "endpoints-s3-policy"
  path   = "/"
  policy = data.aws_iam_policy_document.endpoints_s3_policy.json
}
resource "aws_iam_role_policy_attachment" "endpoints_s3_policy-attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.endpoints_s3_policy.arn
}

# VPC Endpoints
resource "aws_vpc_endpoint" "endpoints" {
  count             = length(var.vpc_endpoints)
  vpc_id            = module.myVPC.vpc_id
  service_name      = var.vpc_endpoints[count.index]
  vpc_endpoint_type = "Interface"
  private_dns_enabled = "true"
  security_group_ids = [
    aws_security_group.endpoint_sg.id
  ]
  subnet_ids = [module.myVPC.pvt_subnet]
}

# EC2 Instances
resource "aws_instance" "bastion_instance" {
  ami                    = data.aws_ami.amzn_linux2.id
  key_name               = aws_key_pair.key_pair.key_name
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  subnet_id              = module.myVPC.public_subnet
  iam_instance_profile   = aws_iam_instance_profile.ec2_instance_profile.name
  root_block_device {
    delete_on_termination = "true"
    encrypted             = "true"
    volume_size           = var.root_block_device.size
    volume_type           = var.root_block_device.type
  }
  user_data                   = file("scripts/user-data.sh")
  associate_public_ip_address = "true"

  tags = {
    Name = "${var.appName}-bastion"
  }
}
resource "aws_instance" "private_instance" {
  ami                    = data.aws_ami.amzn_linux2.id
  key_name               = aws_key_pair.key_pair.key_name
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  subnet_id              = module.myVPC.pvt_subnet
  iam_instance_profile   = aws_iam_instance_profile.ec2_instance_profile.name
  root_block_device {
    delete_on_termination = "true"
    encrypted             = "true"
    volume_size           = var.root_block_device.size
    volume_type           = var.root_block_device.type
  }
  user_data = file("scripts/user-data.sh")

  tags = {
    Name = "${var.appName}-private"
  }
}