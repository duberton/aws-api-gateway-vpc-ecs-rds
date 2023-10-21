resource "aws_secretsmanager_secret" "db_secrets" {
  name                           = "db_secrets"
  recovery_window_in_days        = 0
  force_overwrite_replica_secret = true
}

resource "aws_secretsmanager_secret_version" "db_secrets_version" {
  secret_id = aws_secretsmanager_secret.db_secrets.id
  secret_string = jsonencode({
    user     = "duberton",
    password = "secret-password"
  })
}

resource "aws_secretsmanager_secret" "dd_api_key" {
  name                           = "dd_api_key"
  recovery_window_in_days        = 0
  force_overwrite_replica_secret = true
}

resource "aws_secretsmanager_secret_version" "dd_api_key_version" {
  secret_id = aws_secretsmanager_secret.dd_api_key.id
  secret_string = jsonencode({
    key     = "key"
  })
}