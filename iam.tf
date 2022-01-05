module "mongodb_backup_s3_storage_user" {
  source          = "dasmeta/modules/aws//modules/aws-iam-user"
  create_user     = var.create_user
  username        = var.backup_user_name
  console         = false
  policy          = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": "s3:PutObject",
        "Resource": "arn:aws:s3:::${var.s3_bucket}/*"
      }
    ]
  })
}
