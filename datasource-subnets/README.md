# Get the list of all subnets attached a VPC

This terraform template is to fetch all the subnets that are attached to a VPC.

## Usage

Provide **_VPC id_** for proper functioning of the tempalte.

## Output

```bash
Outputs:

subnetList = {
  "subnet-12345" = {
    "az" = "us-east-1b"
    "cidr" = "10.0.5.0/24"
    "id" = "subnet-12345"
    "name" = "playbox-subnet-B"
  }
  "subnet-12ef45" = {
    "az" = "us-east-1a"
    "cidr" = "10.0.7.0/24"
    "id" = "subnet-12ef45"
    "name" = "playbox-subnet-A"
  }
}
```
