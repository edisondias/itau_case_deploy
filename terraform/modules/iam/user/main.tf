resource "aws_iam_user" "user" {
  name = "${var.user_name}"
  path = "${var.path_name}"
  force_destroy = true
}

resource "aws_iam_user_login_profile" "user" {
  user    = "${aws_iam_user.user.name}"
  pgp_key = "keybase:teste"
}

output "password" {
  value = "${aws_iam_user_login_profile.user.encrypted_password}"
}
