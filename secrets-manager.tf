module "secrets-manager" {
  source = "git::https://github.com/adamyanlina/secrets-manager-terraform.git//modules/secrets-manager"
  secrets_manager_name = var.secrets_manager_name
}