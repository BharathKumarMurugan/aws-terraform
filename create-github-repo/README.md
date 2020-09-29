# Create GitHub Repository

Create a GitHub repository from terraform

## Installation

* Create a Private Access Token (PAT) from your GitHub Account.
* Copy and save Github Token and Github Owner as environment variables (use ___TF_VAR___ prefix)
```bash
git clone https://github.com/BharathKumarMurugan/aws-terraform.git
cd create-github-repo/

terraform init
terraform plan
terraform apply --auto-approve
terraform destroy --auto-approve
```