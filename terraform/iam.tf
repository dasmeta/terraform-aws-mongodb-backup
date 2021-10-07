module "mongodb-backup-s3-storage-user" {
  source          = "dasmeta/modules/aws//modules/aws-iam-user"
  create_user     = var.create-user
  username        = var.backup_user_name
  console         = var.create-iam-user-login-profile
  policy          = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::${var.s3-bucket}" # arn resource 
        }
    ]
})
}
