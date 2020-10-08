# AWS Environment Provisioning - Terraform Automation

Terraform templates for aws environment provisioning

Scenario | Template
-------- | --------
Create Custom VPC _(VPC, Internet Gateway, Public Subent, Security Group, EC2 Instance)_ | [Click Here](creating-custom-vpc)
Create VPC with NAT Gateway _(VPC, Internet Gateway, Public & Private Subents, Security Group, EIP, NAT Gateway)_ | [Click Here](vpc-with-nat)
Create an IAM User | [Click Here](iam-user)
Create an IAM Role | [Click Here](iam-role)
Create an EKS Cluster with EC2 Node group | [Click Here](eks-cluster)
Dynamically allocate CIDR block to Subnets | [Click Here](cidrsubnet-function)
Provision resource ***if Prod*** environment ***else*** do not provision | [Click Here](conditional-operator)
Dynamically create number of Subnets based on the number of AZs in the given region | [Click Here](dynamic-azs)
Create Lambda Function and trigger email using AWS SES | [Click Here](create-lambda-function)
Create VPC on different environments using module | [Click Here](create-vpc-with-modules)
Create a GitHub Repository | [Click Here](create-github-repo)
Create an EC2 instance using JSON configuration | [Click Here](ec2-using-json-conf)
Create a S3 bucket | [Click Here](s3)
Create an Application Load Balancer | [Click Here](load-balancer)
Create an Auto Scaling Group | [Click Here](autoscaling-group)


## Installation

```bash
terraform init
```
* Initialize the working directory.

```bash
terraform plan
```
* What actions are necessary to achieve the _desired state_ specified in the configuration files.

```bash
terraform apply (OR)
terraform apply --auto-approve
```
* Apply changes required to reach the _desired state_ of the configuration or the pre-determined set of actions generated by a *terraform plan*

```bash
terraform destroy
```
* **Terminates resources** defined in the configuration files.
