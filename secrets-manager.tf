module "secrets_manager" {
  source = "git::https://github.com/adamyanlina/secrets-manager-terraform.git//modules/secrets-manager"
  secrets_map = {
    mongodb_uri = {
      secret_name  = "/db/mongodb/uri"
      secret_value = "mongodb:testusername:testpass.someid.net"
      secret_key   = "MONGODB_URI"
    }
    mongodb_host = {
      secret_name  = "db/mongodb/host"
      secret_value = "localhost"
      secret_key   = "MONGODB_HOST"
    }
    mongodb_username = {
      secret_name  = "/db/mongodb/username"
      secret_value = "testusername"
      secret_key   = "MONGODB_INITDB_ROOT_USERNAME"
    }
    mongodb_password = {
      secret_name  = "db/mongodb/password"
      secret_value = "testpass"
      secret_key   = "MONGODB_INITDB_ROOT_PASSWORD"
    }
  }
}