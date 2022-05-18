# About
Helm chart install Terraform module to backup and restore a Mongo database.

## Usage

`mongodb_backup_minimal`:


```hcl

module mongodb_backup_minimal {
    source  = "dasmeta/mongodb-backup/aws"

    mongodb_host                    = "localhost"
    mongodb_username                = "root"
    mongodb_password                = "password"
    cron_schedule                   = "0 3 * * *" # “every day at 03:00 am”
    run_as_daemon                   = "false"
    init_backup                     = "false"
    backup_user_name                = "aws-iam-user"
    s3_bucket                       = "aws-s3-bucket-name" # it suppose this bucket already creaated
}

```

`mongodb_backup_connection_url`:

```hcl
module mongodb_backup_connection_url {
    source  = "dasmeta/mongodb-backup/aws"

    app_name   = "test"
    mongodb_host                    = "localhost"
    mongodb_uri                     = "mongodb+srv://..."
    cron_schedule                   = "*/5 * * * *" 
    run_as_daemon                   = "false"
    init_backup                     = "false"
    backup_user_name                = "backup_user"
    s3_bucket                       = "mongoatlas-dev-backup" 
}
```

`mongodb_backup_advanced`:


```hcl

module mongodb_backup_advanced {
    source  = "dasmeta/mongodb-backup/aws"

    # MongoDB config
    mongodb_host                    = ""
    mongodb_username                = ""
    mongodb_password                = ""
    mongodb_port                    = ""
    mongodb_database                = ""
    mongodb_exclude-collections     = ""

    # Helm backup config
    cron_schedule                   = ""
    max_backups                     = ""
    run_as_daemon                   = ""
    init_backup                     = ""
    init_restore                    = ""

    # AWS S3 bucket config
    backup_user_name                = ""
    s3_bucket                       = ""
    aws_default_region              = ""
}

```

If you want to use AWS Secrets Manager as a keystore for connecting to MongoDB, you can create `secrets-manager` module like belov:


```hcl
module "secrets-manager" {
  source = "git::https://github.com/adamyanlina/secrets-manager-terraform.git//modules/secrets-manager"

  secrets = {
    (var.secret_id) = {
      description = var.secret_description
      secret_key_value = {
        mongodb_uri = var.mongodb_uri
        mongodb_host = var.mongodb_host
        mongodb_username = var.mongodb_username
        mongodb_password = var.mongodb_password
      }
      recovery_window_in_days = var.recovery_window_in_days
    }
  }

  tags = {
    Owner       = "Admin"
    Environment = "dev"
    Terraform   = true
  }
}

```
Create `variables` like below:

```hcl

variable "secret_id" {
  description = "Secret ID"
  type = string
  default = "lina/db/mongodb"
}

variable "secret_description" {
    description = "Secret Description"
    type = string
    default = "SM Description"
}

variable "recovery_window_in_days" {
  description = "Specifies the number of days that AWS Secrets Manager waits before it can delete the secret. This value can be 0 to force deletion without recovery or range from 7 to 30 days."
  type = number
  default = 7
}

```

Example `secrets-manager` module usage in `mongodb_backup_minimal`

```hcl
data aws_secretsmanager_secret "mongodb-secrets-repo" {
    name = var.secret_id
}

data "aws_secretsmanager_secret_version" "secrets" {
  secret_id = data.aws_secretsmanager_secret.mongodb-secrets-repo.id
}

module mongodb_backup_minimal {
    source  = "dasmeta/mongodb-backup/aws"

    mongodb_host                    = jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)["mongodb_host"]
    mongodb_username                = jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)["mongodb_username"]
    mongodb_password                = jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)["mongodb_password"]
    cron_schedule                   = "0 3 * * *" # “every day at 03:00 am”
    run_as_daemon                   = "false"
    init_backup                     = "false"
    backup_user_name                = "aws-iam-user"
    s3_bucket                       = "aws-s3-bucket-name" # it suppose this bucket already creaated
}

```

### Environment variables

#### `Note: Some variables are required` 
| Environment Variables | Description |
| ------ | ------ |
|`mongodb_host`|(required) This is gonna be Mongo database Host name|
|`mongodb_port`|(Optional) Mongo database host Port|
|`mongodb_uri`|(Optional) Mongo connection uri|
|`mongodb_username`|(required) Mongo database username|
|`mongodb_password`|(required) Mongo database password|
|`aws_default_region`|(required) Set aws default region. See [Amazon Web Services](https://console.aws.amazon.com/)|
|`backup_user_name`|(required) this is the aws user name to create and provide accesses for pushing backup to S3|
|`s3_bucket`|(Optional) If bucket variable is set the backups will be shipped/restored to/from Amazon S3 Bucket. `Otherwise It will be saved locally.`|
|`max_backups`| (Optional) Count of maximum backups on local machine. `Necessary if S3_BUCKET variable is not set. Default value is 30`|
|`cron_schedule`| Please visit [CRON SCHEDULE](https://crontab.guru/) to choose your specific schedule time.|
|`run_as_daemon`| in case this prop value is "true" the an "Deployment" kind (k8s  object type) will be created else wise the kind will be "CronJob".|
|`init_backup`|(Optional) To make mongo backup on container startup mark value `true`. `Default is: 'false'`. If `S3_BUCKET` is set, the latest backup will be shipped to bucket. Otherwise, database will be saved on local volume.|
|`init_restore`|(Optional) To make mongo restore on container startup mark value `true`. `Default is: 'false'`. If `S3_BUCKET` is set, the latest backup will be downloaded from bucket. Otherwise, database will be restored from the local volume.|
