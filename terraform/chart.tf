resource "helm_release" "install-helm-chart" {
  name       = "mongodb-backup-aws"
  chart      = "/Users/mpoghosyan/Documents/Projects/DasMeta/mongo-backup-aws/helm/mongodb-backup-aws"

  set {
      name  = "config.MONGODB_HOST"
      value = var.mongodb-host
      type  = "string"
    }
  set  {
    name  = "config.MONGODB_DATABASE"
    value = var.mongodb-database
    type  = "string"
  }
  set  {
    name  = "config.MONGODB_EXCLUDE_COLLECTIONS"
    value = var.mongodb-exclude-callection
    type  = "string"
  }
  set  {
      name  = "config.S3_BUCKET"
      value = var.s3-bucket
      type  = "string"
    }
  set {
      name  = "config.CRON_SCHEDULE"
      value = var.schedule
      type  = "string"
    }
  set {
      name  = "config.AWS_DEFAULT_REGION"
      value = var.aws-default-region
      type  = "string"
    }
  set {
      name  = "config.MONGODB_PORT"
      value = var.mongodb-port
      type  = "string"
    }
  set {
      name  = "config.MAX_BACKUPS"
      value = var.max-backups
      type  = "string"
    }
  set {
      name  = "config.RUN_AS_DAEMON"
      value = var.run-as-demond
      type  = "string"
    }
  set {
      name  = "config.INIT_BACKUP"
      value = var.init-backup
      type  = "string"
    }
  set {
      name  = "config.INIT_RESTORE"
      value = var.init-restore
      type  = "string"
    }
  set_sensitive {
      name  = "config.AWS_ACCESS_KEY_ID"
      value = var.create-user ? module.iam_user.iam_access_key_id : var.aws-access-key-id
      type  = "string"
    }
  set_sensitive {
      name  = "config.AWS_SECRET_ACCESS_KEY"
      value = var.create-user ? nonsensitive(module.iam_user.iam_access_key_secret) : var.aws-secret-access-key
      type  = "string"
    }
  set_sensitive {
      name  = "config.MONGODB_INITDB_ROOT_USERNAME"
      value = var.mongodb-username
      type  = "string"
    }
  set_sensitive {
      name  = "config.MONGODB_INITDB_ROOT_PASSWORD"
      value = var.mongodb-password
      type  = "string"
    }

}