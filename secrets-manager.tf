data aws_secretsmanager_secret "mongodb-secrets-repo" {
    name = "lina/db/mongodb"
}

data "aws_secretsmanager_secret_version" "secrets" {
  secret_id = data.aws_secretsmanager_secret.mongodb-secrets-repo.id
}