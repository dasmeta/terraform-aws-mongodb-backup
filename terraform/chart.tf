module "release11" {
  source  = "terraform-module/release/helm"
  version = "2.7.0"

  namespace  = "default"
  repository =  "https://charts.helm.sh/stable"

  app = {
    name          = "mongodb-backup-aws"
    version       = "0.1.0"
    chart         = "/Users/mpoghosyan/Documents/Projects/DasMeta/mongo-backup-aws/helm/mongodb-backup-aws"
    force_update  = true
    wait          = true
    recreate_pods = false
    deploy        = 1
  }

  # values = [templatefile("values.yml")]


  set = [
    {
      name  = "values.config.MONGODB_HOST"
      value = var.mongodb-host
    },
    {
      name  = "values.config.MONGODB_DATABASE"
      value = var.mongodb-database
    },
     {
      name  = "values.config.MONGODB_EXCLUDE_COLLECTIONS"
      value = var.mongodb-exclude-callection
    },
    {
      name  = "values.config.S3_BUCKET"
      value = var.s3-bucket
    },
    {
      name  = "values.config.CRON_SCHEDULE"
      value = var.schedule
    },
    # {
    #   name  = "config.INIT_BACKUP"
    #   value = var.backup-on-start
    # },
    {
      name  = "values.config.AWS_DEFAULT_REGION"
      value = var.aws-default-region
    },
     {
      name  = "values.config.MONGODB_PORT"
      value = var.mongodb-port
    },
    {
      name  = "values.config.MAX_BACKUPS"
      value = var.max-backups
    },
    {
      name  = "values.config.RUN_AS_DAEMON"
      value = var.run-as-demond
    },
    {
      name  = "values.config.INIT_BACKUP"
      value = var.init-backup
    },
    {
      name  = "values.config.INIT_RESTORE"
      value = var.init-restore
    },
  ]

  set_sensitive = [
    {
      path  = "values.values.config.AWS_ACCESS_KEY_ID"
      value = var.create-user ? module.iam_user.iam_access_key_id : var.aws-access-key-id
    },
    {
      path  = "values.values.config.AWS_SECRET_ACCESS_KEY"
      value = var.create-user ? nonsensitive(module.iam_user.iam_access_key_secret) : var.aws-secret-access-key
    },
    {
      path  = "values.values.config.MONGODB_INITDB_ROOT_USERNAME"
      value = var.mongodb-username
    },
    {
      path  = "values.values.config.MONGODB_INITDB_ROOT_PASSWORD"
      value = var.mongodb-password
    },
  ]
}
