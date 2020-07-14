locals {
  common_tags = {
    "Application" = "${var.app_name}"
    "Environment" = "${var.env}"
    "Owner"       = "edias"
  }
}

provider "aws" {
  region  = "${var.region}"
  profile = "${var.profile}"
  version = "1.13.0"
}

terraform {
  backend "s3" {}
}

data "aws_vpc" "vpc" {
  # id = "${var.vpc_id}"
  cidr_block = "${var.cidr_vpc}"
}

data "aws_subnet" "subnet1" {
  # id = "${var.vpc_id}"
  cidr_block = "${var.cidr_subnet1}"
}

data "aws_subnet" "subnet2" {
  # id = "${var.vpc_id}"
  cidr_block = "${var.cidr_subnet2}"
}

module "ec2" {
  source                           = "git::ssh://git@github.com/moip/terraform-module-aws-ec2.git?ref=v2.0.0"

  number_of_instances              = "${var.ec2_number}"
  app_name                         = "${var.app_name}"
  ami_id                           = "${var.ami_id}"
  key_pair                         = "${var.key_pair}"
  # subnet_id                        = "${data.terraform_remote_state.network.private_subnet_app_id}"
  subnet_id                        = ["${data.aws_subnet.subnet1.id}","${data.aws_subnet.subnet2.id}"]
  instance_type                    = "${var.instance_type}"
  availability_zone                = ["${data.aws_subnet.subnet1.availability_zone}"]
  default_sgroups                  = ["${var.ec2_sg}","${aws_security_group.ec2.id}"]
  public_ip                        = "${var.public_ip}"
  iam_role_name                    = "${aws_iam_role.default_iam_role.name}"
  env                              = "${var.env}"
  ec2_file                         = "${var.ec2_file}"

  tags                             = "${local.common_tags}"
}

module "dns" {
  source                           = "../../../../modules/route53"

  app_name                         = "${var.app_name}"
  number_of_instances              = "${var.ec2_number}"
  zone_id                          = "${var.zone_id}"
  env                              = "${var.env}"
  # name    = "aws-${var.env}-${var.app_name}.${var.domain}"
  # name                             = "${var.app_name}.${var.domain}"
  ip                               = "${module.ec2.instance_private_ip}"
}
