module "release" {
  source = "terraform-module/release/helm"
  depends_on = [
    module.mongodb_backup_s3_storage_user
  ]
  version = "2.8.2"

  namespace  = var.namespace
  repository = "https://charts.helm.sh/stable"

  app = {
    name          = var.app_name
    version       = var.app_version
    chart         = "${path.module}/helm/mongodb-backup-aws"
    force_update  = true
    wait          = false
    recreate_pods = false
    deploy        = 1
  }

  values = []

  set = [
    {
      name  = "resources.limits.cpu"
      value = "${var.resources.limits.cpu}"
    },
    {
      name  = "resources.limits.memory"
      value = "${var.resources.limits.memory}"
    },
    {
      name  = "resources.requests.cpu"
      value = "${var.resources.requests.cpu}"
    },
    {
      name  = "resources.requests.memory"
      value = "${var.resources.requests.memory}"
    },
    {
      name  = "volume.storageClass"
      value = "${var.volume_storageClass}"
    },
    {
      name  = "volume.size"
      value = "${var.volume_size}"
    },
    {
      name  = "config.MONGODB_HOST"
      value = "${var.mongodb_host}"
    },
    {
      name  = "config.MONGODB_PORT"
      value = "${var.mongodb_port}"
    },
    {
      name  = "config.MONGODB_DATABASE"
      value = "${var.mongodb_database}"
    },
    {
      name  = "config.MONGODB_EXCLUDE_COLLECTIONS"
      value = "${var.mongodb_exclude_collections}"
    },
    {
      name  = "config.S3_BUCKET"
      value = "${var.s3_bucket}"
    },
    {
      name  = "config.AWS_DEFAULT_REGION"
      value = "${var.aws_default_region}"
    },
    {
      name  = "config.CRON_SCHEDULE"
      value = "${var.cron_schedule}"
    },
    {
      name  = "config.MAX_BACKUPS"
      value = "${var.max_backups}"
    },
    {
      name  = "config.INIT_BACKUP"
      value = "${var.init_backup}"
    },
    {
      name  = "config.INIT_RESTORE"
      value = "${var.init_restore}"
    },
    {
      name  = "config.RUN_AS_DAEMON"
      value = "${var.run_as_daemon}"
    },
    {
      name  = "config.MONGODB_URI"
      value = "${var.mongodb_uri}"
    }
  ]

  set_sensitive = [
    {
      path  = "config.AWS_ACCESS_KEY_ID"
      value = "${module.mongodb_backup_s3_storage_user.iam_access_key_id}"
    },
    {
      path  = "config.AWS_SECRET_ACCESS_KEY"
      value = "${module.mongodb_backup_s3_storage_user.iam_access_key_secret}"
    },
    {
      path  = "config.MONGODB_INITDB_ROOT_USERNAME"
      value = "${var.mongodb_username}"
    },
    {
      path  = "config.MONGODB_INITDB_ROOT_PASSWORD"
      value = "${var.mongodb_password}"
    },
  ]
}
