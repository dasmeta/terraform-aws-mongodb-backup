variable volume-size {
  type        = string
  default     = "10Gi"
  description = "Size of the backup volume storage. Should be enough big to fit backup files."
}

variable volume-storageClass {
  type        = string
  default     = "gp2"
  description = "Volume strage class AWS will be claimed for. No need for fast storage as this will be used once during backup."
}

variable mongodb-host {
  type        = string
  default = "localhost"
  description = "Mongodb host name backup script will be taking data from."
}

variable mongodb-database {
  type        = string
  default     = ""
  description = "Mongodb database to be backed up. All databases will be backed up if not specified."
}

variable mongodb-exclude-collections {
  type        = string
  default     = ""
  description = "Mongodb collections to be excluded from the backup. All collections will be backed up if not specified."
}

variable mongodb-username {
  type        = string
  description = "Mongodb user name script will need to pull data from mongodb."
  sensitive = true
}

variable mongodb-password {
  type        = string
  description = "Mongodb user password script will need to pull data from mongodb."
  sensitive = true
}

variable mongodb-port {
  type        = string
  default     = "27017"
  description = "Mongodb user password script will need to pull data from mongodb."
}
variable s3-bucket {
  type        = string
  description = "The bucket backups will be stored."
}
variable run-as-demond {
  type        = string
  description = "run as demond"
}
variable cron-schedule {
  type        = string
  default     = "3 0 * * *"
  description = "Backup schedule, in crojob format. E.g. '3 0 * * *'"
}

variable max-backups {
  type        = string
  default     = "30"
  description = "Max backups'"
}

variable init-backup {
  type        = string
  default     = false
  description = "If enabled scripts will do backup right on the start and then according to the schedule."
}

variable init-restore {
  type        = string
  default     = false
  description = "If enabled scripts will do restore right on the start and then according to the schedule."
}
variable aws-access-key-id {
  type        = string
  default     = "aws-access-key-id"
  description = "AWS Access Key ID script will need to push backups into the S3 bucket."
  sensitive   = true
}

variable aws-secret-access-key {
  type        = string
  default     = "aws-secret-access-key"
  description = "AWS Secret Access Key script will need to push backups into the S3 bucket."
  sensitive   = true
}
variable aws-default-region {
  type        = string
  default     = "eu-central-1"
  description = "aws-default-region."
}

variable backup_user_name {
  type        = string
  default     = "mongodb-backup-s3-bucket"
  description = "Backup user name for s3 bucket"
}

variable create-user {
  type        = bool
  default     = true
  description = "create user."
}

variable create-iam-user-login-profile {
  type        = bool
  default     = false
  description = "create-iam-user-login-profile."
}

variable create-iam-access-key {
  type        = bool
  default     = true
  description = "create-iam-access-key."
}
