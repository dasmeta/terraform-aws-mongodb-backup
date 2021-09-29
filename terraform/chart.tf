module "release" {
  source  = "terraform-module/release/helm"
    depends_on = [
      module.iam_user
    ]
  version = "2.6.0"

  namespace  = "default"
  repository =  "https://charts.helm.sh/stable"

  app = {
    name          = "mongodb-backup-aws"
    version       = "0.1.0"
    chart         = "${path.module}/../helm/mongodb-backup-aws"
    force_update  = true
    wait          = true
    recreate_pods = false
    deploy        = 1
  }

  values = []

  set = [
    {
      name  = "volume.storageClass"
      value = "\"${var.volume-storageClass}\""
    },
    {
      name  = "volume.size"
      value = "\"${var.volume-size}\""
    },
    {
      name  = "config.MONGODB_HOST"
      value = "\"${var.mongodb-host}\""
    },
    {
      name  = "config.MONGODB_PORT"
      value = "\"${var.mongodb-port}\""
    },
    {
      name  = "config.MONGODB_DATABASE"
      value = "\"${var.mongodb-database}\""
    },
    {
      name  = "config.MONGODB_EXCLUDE_COLLECTIONS"
      value = "\"${var.mongodb-exclude-collections}\""
    },
    {
      name  = "config.S3_BUCKET"
      value = "\"${var.s3-bucket}\""
    },
    {
      name  = "config.AWS_DEFAULT_REGION"
      value = "\"${var.aws-default-region}\""
    },
    {
      name  = "config.CRON_SCHEDULE"
      value = "\"${var.cron-schedule}\""
    },
    {
      name  = "config.MAX_BACKUPS"
      value = "\"${var.max-backups}\""
    },
    {
      name  = "config.INIT_BACKUP"
      value = "\"${var.init-backup}\""
    },
    {
      name  = "config.INIT_RESTORE"
      value = "\"${var.init-restore}\""
    },
    {
      name  = "config.RUN_AS_DAEMON"
      value = "\"${var.run-as-demond}\""
    },
  ]

  set_sensitive = [
    {
      path  = "config.AWS_ACCESS_KEY_ID"
      value = "\"${module.iam_user.iam_access_key_id}\""
    },
    {
      path  = "config.AWS_SECRET_ACCESS_KEY"
      value = "\"${module.iam_user.iam_access_key_secret}\""
    },
    {
      path  = "config.MONGODB_INITDB_ROOT_USERNAME"
      value = "\"${var.mongodb-username}\""
    },
    {
      path  = "config.MONGODB_INITDB_ROOT_PASSWORD"
      value = "\"${var.mongodb-password}\""
    },
  ]
}