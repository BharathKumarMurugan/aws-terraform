resource "github_repository" "terraform-repo"{
    name = var.repo_name
    description = "Terraform and Github Integration demo repository"
    visibility = "public" # public or private
    license_template = var.github_license
}
