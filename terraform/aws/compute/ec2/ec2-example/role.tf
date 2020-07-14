data "aws_iam_policy_document" "instance-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "default_iam_role" {
  # count              = "${var.number_of_instances}"
  # name               = "${var.number_of_instances > 1 ? format("aws-%s-%s-%02d", var.env, var.app_name, count.index + 1) : format("aws-%s-%s", var.env, var.app_name)}"
  name               = "${format("role-%s-%s", var.env, var.app_name)}"
  assume_role_policy = "${data.aws_iam_policy_document.instance-assume-role-policy.json}"
}

resource "aws_iam_role_policy" "describe-instances" {
  count              = "${var.ec2_number}"
  name               = "DescribeInstances"
  role               = "${element(aws_iam_role.default_iam_role.*.id, count.index)}"

  policy = <<EOF
{
     "Version": "2012-10-17",
     "Statement": [{
        "Effect": "Allow",
        "Action": [
          "ec2:DescribeInstances"
        ],
        "Resource": "*"
      }
     ]
}
EOF
}

# resource "aws_iam_role_policy_attachment" "s3_access" {
#   count              = "${var.ec2_number}"
#   role               = "${element(aws_iam_role.default_iam_role.*.id, count.index)}"
#   policy_arn             = "arn:aws:iam::026783351078:policy/s3yumrepo"
# }

# resource "aws_iam_role_policy" "s3policy" {
#   count              = "${var.ec2_number}"
#   name               = "s3yumrepo"
#   role               = "${element(aws_iam_role.default_iam_role.*.id, count.index)}"
#
#   policy = <<EOF
# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Action": [
#                 "s3:ListBucket",
#                 "s3:GetBucketAcl"
#             ],
#             "Effect": "Allow",
#             "Resource": [
#                 "arn:aws:s3:::moip-*-yumrepo"
#             ]
#         },
#         {
#             "Action": [
#                 "s3:GetObject",
#                 "s3:GetObjectAcl"
#             ],
#             "Effect": "Allow",
#             "Resource": [
#                 "arn:aws:s3:::moip-*-yumrepo/*"
#             ]
#         }
#     ]
# }
# EOF
# }
