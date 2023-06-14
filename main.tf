data "local_file" "this" {
  filename = var.local_file
}

locals {
  file = data.local_file.this.content
}

resource "aws_secretsmanager_secret" "secret" {
  name        = var.secret_name
  description = var.secret_description
  tags        = var.tags
}

resource "aws_secretsmanager_secret_version" "version" {
  secret_id = aws_secretsmanager_secret.secret.id
  #secret_string = jsonencode(local.file)
  secret_string = local.file
}
