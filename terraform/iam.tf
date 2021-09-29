module "iam_user" {
    source  = "terraform-aws-modules/iam/aws//modules/iam-user"
    version = "4.6.0"
    name                          = var.backup_user_name
    create_user                   = true
    create_iam_user_login_profile = var.create-iam-user-login-profile
    create_iam_access_key         = var.create-iam-access-key
}
