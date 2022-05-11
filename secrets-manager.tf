data aws_secretsmanager_secret "mongodb-secrets-repo" {
    name = var.secret_id
}

data "aws_secretsmanager_secret_version" "secrets" {
  secret_id = data.aws_secretsmanager_secret.mongodb-secrets-repo.id
}