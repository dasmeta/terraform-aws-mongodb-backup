module "mongo-backup" {
    source = ""

    # MongoDB config
    mongodb-host                    = ""
    mongodb-username                = ""
    mongodb-password                = ""
    mongodb-port                    = ""
    mongodb-database                = ""
    mongodb-exclude-collections     = ""

    # Helm backup config
    cron-schedule                   = ""    max-backups                     = ""
    run-as-demond                   = ""
    init-backup                     = ""
    init-restore                    = ""

    # AWS S3 backet config
    backup_user_name                = ""
    s3-bucket                       = ""
    aws-default-region              = ""
}
