
resource "aws_iam_user_policy" "iam_user_policy" {
  count = var.create-user ? 1 : 0
  name = "s3-buckert-mongo"
  user = module.iam_user.iam_user_name
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": "*"
        }
    ]
})
}
