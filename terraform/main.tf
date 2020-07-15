variable "access_key" {}
variable "secret_key" {}

provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "us-east-1"
}

data "aws_ami" "node_app" {
  most_recent = true

  filter {
    name   = "name"
    values = ["nodejs-app-edias*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["970240551929"]
}

resource "aws_security_group" "nodesg" {
  name = "security_group_for_node"
  ingress {
    from_port = 3000
    to_port = 3000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "node_app" {
  ami = "${data.aws_ami.node_app.id}"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.nodesg.name}"]

  user_data = <<-EOF
              #!bin/bash
              cd /home/ubuntu/itau_case_app
              npm install
              npm start
              EOF

  tags = {
      Name = "edias - node_app"
  }


}