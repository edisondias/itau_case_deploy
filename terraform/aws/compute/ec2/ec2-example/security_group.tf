#Security groups
#ec2
resource "aws_security_group" "ec2" {
  name	      = "moip-sg-${var.env}-${var.app_name}"
  description = "Used for public and private instances for instances access"
  vpc_id      = "${data.aws_vpc.vpc.id}"

  #SSH
  ingress {
    from_port      = 22
    to_port        = 22
    protocol       = "tcp"
    cidr_blocks    = ["10.70.0.253/32","177.43.218.115/32"]
  }
  ingress {
    from_port      = 22
    to_port        = 22
    protocol       = "tcp"
    cidr_blocks    = ["158.69.210.24/32","186.248.78.146/32"]
  }

  ingress {
    from_port      = 443
    to_port        = 443
    protocol       = "tcp"
    cidr_blocks    = ["0.0.0.0/0"]
  }

  ingress {
    from_port      = 80
    to_port        = 80
    protocol       = "tcp"
    cidr_blocks    = ["0.0.0.0/0"]
  }

  egress {
    from_port      = 0
    to_port        = 0
    protocol       = "-1"
    cidr_blocks	   = ["0.0.0.0/0"]
  }

  tags             = "${merge(local.common_tags, map("Name", format("sg-%s-%s", var.env, var.app_name)))}"
  # tags             = "${local.common_tags}"

}
