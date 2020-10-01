variable "GITHUB_TOKEN" {} # export an environment variable TF_VAR_GITHUB_TOKEN
variable "GITHUB_OWNER" {} # export an environment variable TF_VAR_GITHUB_OWNER
variable "repo_name"{
    default = "terraform-github-integration-repo"
}
variable "github_license" {
    default = "gpl-3.0"
}
