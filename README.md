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
### Environment variables

#### `Note: Some variables are required`
| Environment Variables | Description                                                                                                                                                                                                                          |
| --------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `mongodb_host`        | (required) This is gonna be Mongo database Host name                                                                                                                                                                                 |
| `mongodb_port`        | (Optional) Mongo database host Port                                                                                                                                                                                                  |
| `mongodb_uri`         | (Optional) Mongo connection uri                                                                                                                                                                                                      |
| `mongodb_username`    | (required) Mongo database username                                                                                                                                                                                                   |
| `mongodb_password`    | (required) Mongo database password                                                                                                                                                                                                   |
| `aws_default_region`  | (required) Set aws default region. See [Amazon Web Services](https://console.aws.amazon.com/)                                                                                                                                        |
| `backup_user_name`    | (required) this is the aws user name to create and provide accesses for pushing backup to S3                                                                                                                                         |
| `s3_bucket`           | (Optional) If bucket variable is set the backups will be shipped/restored to/from Amazon S3 Bucket. `Otherwise It will be saved locally.`                                                                                            |
| `max_backups`         | (Optional) Count of maximum backups on local machine. `Necessary if S3_BUCKET variable is not set. Default value is 30`                                                                                                              |
| `cron_schedule`       | Please visit [CRON SCHEDULE](https://crontab.guru/) to choose your specific schedule time.                                                                                                                                           |
| `run_as_daemon`       | in case this prop value is "true" the an "Deployment" kind (k8s  object type) will be created else wise the kind will be "CronJob".                                                                                                  |
| `init_backup`         | (Optional) To make mongo backup on container startup mark value `true`. `Default is: 'false'`. If `S3_BUCKET` is set, the latest backup will be shipped to bucket. Otherwise, database will be saved on local volume.                |
| `init_restore`        | (Optional) To make mongo restore on container startup mark value `true`. `Default is: 'false'`. If `S3_BUCKET` is set, the latest backup will be downloaded from bucket. Otherwise, database will be restored from the local volume. |
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_mongodb_backup_s3_storage_user"></a> [mongodb\_backup\_s3\_storage\_user](#module\_mongodb\_backup\_s3\_storage\_user) | dasmeta/modules/aws//modules/aws-iam-user | 0.36.8 |
| <a name="module_release"></a> [release](#module\_release) | terraform-module/release/helm | 2.7.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | Helm app/release name | `string` | `"mongodb-backup-aws"` | no |
| <a name="input_app_version"></a> [app\_version](#input\_app\_version) | Helm app/release version | `string` | `"0.1.0"` | no |
| <a name="input_aws_default_region"></a> [aws\_default\_region](#input\_aws\_default\_region) | aws-default-region. | `string` | `"eu-central-1"` | no |
| <a name="input_backup_user_name"></a> [backup\_user\_name](#input\_backup\_user\_name) | Backup user name for s3 bucket | `string` | `"mongodb-backup-s3-bucket"` | no |
| <a name="input_create_user"></a> [create\_user](#input\_create\_user) | Create User for S3 | `bool` | `true` | no |
| <a name="input_cron_schedule"></a> [cron\_schedule](#input\_cron\_schedule) | Backup schedule, in crojob format. E.g. '3 0 * * *' | `string` | `"3 0 * * *"` | no |
| <a name="input_init_backup"></a> [init\_backup](#input\_init\_backup) | If enabled scripts will do backup right on the start and then according to the schedule. | `string` | `false` | no |
| <a name="input_init_restore"></a> [init\_restore](#input\_init\_restore) | If enabled scripts will do restore right on the start and then according to the schedule. | `string` | `false` | no |
| <a name="input_max_backups"></a> [max\_backups](#input\_max\_backups) | Max backups' | `string` | `"30"` | no |
| <a name="input_mongodb_database"></a> [mongodb\_database](#input\_mongodb\_database) | Mongodb database to be backed up. All databases will be backed up if not specified. | `string` | `""` | no |
| <a name="input_mongodb_exclude_collections"></a> [mongodb\_exclude\_collections](#input\_mongodb\_exclude\_collections) | Mongodb collections to be excluded from the backup. All collections will be backed up if not specified. | `string` | `""` | no |
| <a name="input_mongodb_host"></a> [mongodb\_host](#input\_mongodb\_host) | Mongodb host name backup script will be taking data from. | `string` | `"localhost"` | no |
| <a name="input_mongodb_password"></a> [mongodb\_password](#input\_mongodb\_password) | Mongodb user password script will need to pull data from mongodb. | `string` | `""` | no |
| <a name="input_mongodb_port"></a> [mongodb\_port](#input\_mongodb\_port) | Mongodb user password script will need to pull data from mongodb. | `string` | `"27017"` | no |
| <a name="input_mongodb_uri"></a> [mongodb\_uri](#input\_mongodb\_uri) | --uri param from mongodump docs | `string` | `""` | no |
| <a name="input_mongodb_username"></a> [mongodb\_username](#input\_mongodb\_username) | Mongodb user name script will need to pull data from mongodb. | `string` | `""` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Helm app/release namespace | `string` | `"default"` | no |
| <a name="input_resources"></a> [resources](#input\_resources) | Allows to set cpu/memory resources Limits/Requests for deployment/cronjob | <pre>object({<br>    limits = object({<br>      cpu    = string<br>      memory = string<br>    })<br>    requests = object({<br>      cpu    = string<br>      memory = string<br>    })<br>  })</pre> | <pre>{<br>  "limits": {<br>    "cpu": "300m",<br>    "memory": "500Mi"<br>  },<br>  "requests": {<br>    "cpu": "300m",<br>    "memory": "500Mi"<br>  }<br>}</pre> | no |
| <a name="input_run_as_daemon"></a> [run\_as\_daemon](#input\_run\_as\_daemon) | in case of true deployment will be created (as daemon) elwise kube cronJob will be created | `string` | `"false"` | no |
| <a name="input_s3_bucket"></a> [s3\_bucket](#input\_s3\_bucket) | The bucket backups will be stored. | `string` | n/a | yes |
| <a name="input_volume_size"></a> [volume\_size](#input\_volume\_size) | Size of the backup volume storage. Should be enough big to fit backup files. | `string` | `"10Gi"` | no |
| <a name="input_volume_storageClass"></a> [volume\_storageClass](#input\_volume\_storageClass) | Volume strage class AWS will be claimed for. No need for fast storage as this will be used once during backup. | `string` | `"gp2"` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
