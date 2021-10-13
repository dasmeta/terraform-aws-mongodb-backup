# About
Helm chart install Terraform module to backup and restore a Mongo database.

## Usage

`mongodb-backup-minimal`:


```hcl

module mongodb-backup-minimal {
    source  = "dasmeta/mongodb-backup/aws"

    mongodb-host                    = "localhost"
    mongodb-username                = "root"
    mongodb-password                = "password" 
    cron-schedule                   = "0 3 * * *" # “every day at 03:00 am”
    run-as-demond                   = "false"
    init-backup                     = "false"
    backup_user_name                = "aws-iam-user"
    s3-bucket                       = "aws-s3-bucket-name" # it suppose this bucket already creaated
}

```
`mongodb-backup-advanced`:


```hcl

module mongodb-backup-advanced {
    source  = "dasmeta/mongodb-backup/aws"

    # MongoDB config
    mongodb-host                    = ""
    mongodb-username                = ""
    mongodb-password                = ""
    mongodb-port                    = ""
    mongodb-database                = ""
    mongodb-exclude-collections     = ""

    # Helm backup config
    cron-schedule                   = ""    
    max-backups                     = ""
    run-as-demond                   = ""
    init-backup                     = ""
    init-restore                    = ""

    # AWS S3 backet config
    backup_user_name                = ""
    s3-bucket                       = ""
    aws-default-region              = ""
}

```
### Environment variables

#### `Note: Some variables are required` 
| Environment Variables | Description |
| ------ | ------ |
|`mongodb-host`|(required) This is gonna be Mongo database Host name|
|`mongodb-port`|(Optional) Mongo database host Port|
|`mongodb-username`|(required) Mongo database username|
|`mongodb-password`|(required) Mongo database password|
|`aws-default-region`|(required) Set aws default region. See [Amazon Web Services](https://console.aws.amazon.com/)|
|`backup_user_name`|(required) this is the aws user name to create and provide accesses for pushing backup to S3|
|`s3-bucket`|(Optional) If bucket variable is set the backups will be shipped/restored to/from Amazon S3 Bucket. `Otherwise It will be saved locally.`|
|`max-backups`| (Optional) Count of maximum backups on local machine. `Necessary if S3_BUCKET variable is not set. Default value is 30`|
|`cron-schedule`| Please visit [CRON SCHEDULE](https://crontab.guru/) to choose your specific schedule time.|
|`run-as-demond`| in casae this prop value is "true" the an "Deployment" kind (k8s  object type) will be created else wise the kind will be "CronJob".|
|`init-backup`|(Optional) To make mongo backup on container startup mark value `true`. `Default is: 'false'`. If `S3_BUCKET` is set, the latest backup will be shipped to bucket. Otherwise, database will be saved on local volume.|
|`init-restore`|(Optional) To make mongo restore on container startup mark value `true`. `Default is: 'false'`. If `S3_BUCKET` is set, the latest backup will be downloaded from bucket. Otherwise, database will be restored from the local volume.|
