output "ec2_generic_instance" {
  value = "${aws_instance.ec2_generic_instance.*.id}"
}

output "instance_private_ip" {
  value = "${aws_instance.ec2_generic_instance.*.private_ip}"
}

output "instance_public_ip" {
  value = "${aws_instance.ec2_generic_instance.*.public_ip}"
}

# output "instance_role_id" {
#   value = "${aws_iam_instance_profile.default_instance_profile.id}"
# }
