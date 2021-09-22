module "iam_user" {
    source  = "terraform-aws-modules/iam/aws//modules/iam-user"
    version = "4.6.0"
    name = "mher.poghosyan"
    create_user = true
    create_iam_user_login_profile = false
    create_iam_access_key         = true
}

