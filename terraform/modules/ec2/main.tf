resource "aws_iam_instance_profile" "default_instance_profile" {
  name               = "${format("aws-%s-%s", var.env, var.app_name)}"
  role               = "${var.iam_role_name}"
}

resource "aws_instance" "ec2_generic_instance" {
  count                       = "${var.number_of_instances}"

  ami                         = "${var.ami_id}"
  key_name                    = "${var.key_pair}"
  subnet_id                   = "${var.subnet_id[count.index]}"
  instance_type               = "${var.instance_type}"
  availability_zone           = "${var.availability_zone[count.index]}"
  vpc_security_group_ids      = ["${var.default_sgroups}"]
  iam_instance_profile        = "${aws_iam_instance_profile.default_instance_profile.id}"
  associate_public_ip_address = "${var.public_ip}"
  user_data                   = "${file(var.ec2_file)}"

  tags                        = "${merge(var.tags, map("Name", var.number_of_instances > 1 ? format("aws-%s-%s-%02d", var.env, var.app_name, count.index + 1) : format("aws-%s-%s", var.env, var.app_name)))}"


}

resource "aws_eip" "public" {
  count    = "${var.number_of_instances > 0 ? (var.public_ip ? var.number_of_instances : 0) : 0   }"

  instance = "${element(aws_instance.ec2_generic_instance.*.id, count.index)}"
  vpc      = true
}
