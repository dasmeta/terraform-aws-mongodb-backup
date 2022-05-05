variable "volume_size" {
  type        = string
  default     = "10Gi"
  description = "Size of the backup volume storage. Should be enough big to fit backup files."
}

variable "volume_storageClass" {
  type        = string
  default     = "gp2"
  description = "Volume strage class AWS will be claimed for. No need for fast storage as this will be used once during backup."
}

variable "mongodb_uri" {
  type        = string
  default     = ""
  description = "--uri param from mongodump docs"
}

variable "mongodb_host" {
  type        = string
  default     = "localhost"
  description = "Mongodb host name backup script will be taking data from."
}

variable "mongodb_database" {
  type        = string
  default     = ""
  description = "Mongodb database to be backed up. All databases will be backed up if not specified."
}

variable "mongodb_exclude_collections" {
  type        = string
  default     = ""
  description = "Mongodb collections to be excluded from the backup. All collections will be backed up if not specified."
}

variable "mongodb_username" {
  type        = string
  default     = ""
  description = "Mongodb user name script will need to pull data from mongodb."
}

variable "mongodb_password" {
  type        = string
  description = "Mongodb user password script will need to pull data from mongodb."
  default     = ""
}

variable "mongodb_port" {
  type        = string
  default     = "27017"
  description = "Mongodb user password script will need to pull data from mongodb."
}

variable "s3_bucket" {
  type        = string
  description = "The bucket backups will be stored."
}

variable "run_as_daemon" {
  type        = string
  default     = "false"
  description = "in case of true deployment will be created (as daemon) elwise kube cronJob will be created"
}

variable "cron_schedule" {
  type        = string
  default     = "3 0 * * *"
  description = "Backup schedule, in crojob format. E.g. '3 0 * * *'"
}

variable "max_backups" {
  type        = string
  default     = "30"
  description = "Max backups'"
}

variable "init_backup" {
  type        = string
  default     = false
  description = "If enabled scripts will do backup right on the start and then according to the schedule."
}

variable "init_restore" {
  type        = string
  default     = false
  description = "If enabled scripts will do restore right on the start and then according to the schedule."
}

variable "aws_default_region" {
  type        = string
  default     = "eu-central-1"
  description = "aws-default-region."
}

variable "backup_user_name" {
  type        = string
  default     = "lina-db-mongodb-backup-s3-bucket"
  description = "Backup user name for s3 bucket"
}

variable "app_name" {
  type        = string
  default     = "mongodb-backup-aws"
  description = "Helm app/release name"
}

variable "app_version" {
  type        = string
  default     = "0.1.0"
  description = "Helm app/release version"
}

variable "namespace" {
  type        = string
  default     = "default"
  description = "Helm app/release namespace"
}

variable "create_user" {
  type        = bool
  default     = true
  description = "Create User for S3"
}

variable "resources" {
  type = object({
    limits = object({
      cpu    = string
      memory = string
    })
    requests = object({
      cpu    = string
      memory = string
    })
  })
  default = {
    limits = {
      cpu    = "300m"
      memory = "500Mi"
    }
    requests = {
      cpu    = "300m"
      memory = "500Mi"
    }
  }
  description = "Allows to set cpu/memory resources Limits/Requests for deployment/cronjob"
}
