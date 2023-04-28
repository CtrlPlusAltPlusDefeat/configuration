output "iam_terraform_access_key" {
  value = module.iam.terraform_access_key
}

output "iam_terraform_secret_access_key" {
  value     = module.iam.terraform_secret_access_key
  sensitive = true
}

output "iam_github_access_key" {
  value = module.iam.github_access_key
}

output "iam_github_secret_access_key" {
  value     = module.iam.github_secret_access_key
  sensitive = true
}

output "iam_backend_access_key" {
  value = module.iam.backend_access_key
}

output "iam_backend_secret_access_key" {
  value     = module.iam.backend_secret_access_key
  sensitive = true
}