output "iam_terraform_access_key" {
  value = module.iam.terraform_access_key
}

output "iam_terraform_secret_access_key" {
  value     = module.iam.terraform_secret_access_key
  sensitive = true
}

output "iam_configuration_access_key" {
  value = module.iam.configuration_access_key
}

output "iam_configuration_secret_access_key" {
  value     = module.iam.configuration_secret_access_key
  sensitive = true
}