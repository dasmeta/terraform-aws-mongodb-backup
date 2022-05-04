module "secrets-manager" {
  source = "../test-project/modules/secrets-manager"
  secrets_manager_name = var.secrets_manager_name
}