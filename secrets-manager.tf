data aws_secretsmanager_secret "uri-host" {
    name = "mongodb-uhkv"
}

data "aws_secretsmanager_secret_version" "uri-host-secrets" {
  secret_id = data.aws_secretsmanager_secret.uri-host.id
}

data aws_secretsmanager_secret "username-password" {
    name = "mongodb-upkv"
}

data "aws_secretsmanager_secret_version" "username-password-secrets" {
  secret_id = data.aws_secretsmanager_secret.username-password.id
}