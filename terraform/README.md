module "mongo-backup" {
    source = "../../../../DasMeta/mongo-backup-aws/terraform"
    
    #AWS User Config
    backup_user_name                = "mher.poghosyan"
    create-user                     = false
    create-iam-user-login-profile   = false
    create-iam-access-key           = true
    
    # MongoDB config
    mongodb-host                    = "10.107.194.125"
    mongodb-username                = "root"
    mongodb-password                = "mongodb-password"
    mongodb-port                    = "27017"
    mongodb-database                = "admin"
    mongodb-exclude-callection      = ""
    
    # Helm backup config
    schedule                        = "0/1 * * * *"
    #backup-on-start                 = "true"
    max-backups                     = "30"
    run-as-demond                   = "true"
    init-backup                     = "false"
    init-restore                    = "false"
    
    # AWS S3 backet config
    s3-bucket                       = "mongo-backup-1q2w"
    aws-default-region              = "us-east-2"
    aws-access-key-id               = "aws-access-key-id"
    aws-secret-access-key           = "aws-secret-access-key"
}