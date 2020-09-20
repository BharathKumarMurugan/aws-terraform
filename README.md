# AWS Environment Provisioning - Terraform Automation

Terraform templates for aws environment provisioning

Scenario | Template
-------- | --------
Create Custom VPC _(VPC, Internet Gateway, Public Subent, Security Group, EC2 Instance)_ | [Click Here](creating-custom-vpc)
Create VPC with NAT Gateway _(VPC, Internet Gateway, Public & Private Subents, Security Group, EIP, NAT Gateway)_ | [Click Here](vpc-with-nat)
Create an IAM User | [Click Here](iam-user)
Create an IAM Role | [Click Here](iam-role)
Create an EKS Cluster with EC2 Node group | [Click Here](eks-cluster)

## Installation

```bash
terraform init
```

```bash
terraform plan
```

```bash
terraform apply
```
