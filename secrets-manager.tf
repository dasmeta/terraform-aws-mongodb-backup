module "secrets-manager" {
  source = "https://github.com/adamyanlina/secrets-manager-terraform/tree/master/modules/secrets-manager"
  secrets_manager_name = var.secrets_manager_name
}