resource "aws_iam_group" "group" {
  name = "${var.group_name}"
  path = "/"
}

resource "aws_iam_group_policy_attachment" "attach" {
  group      = "${aws_iam_group.group.name}"
  policy_arn = "${var.policy_arn}"
}
