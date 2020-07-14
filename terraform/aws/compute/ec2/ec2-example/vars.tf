variable "app_name" {}
variable "azs" {type = "list"}
variable "env" {}
variable "profile" {}
variable "region" {}
variable "key_pair" {}
variable "ami_id" {}
variable "instance_type" {}
variable "ec2_sg" {type = "list"}
variable "public_ip" {}
variable "ec2_number" {}
variable "ec2_file" {}
variable "zone_id" {}
variable "domain" {}

variable "cidr_vpc" {}
variable "cidr_subnet1" {}
variable "cidr_subnet2" {}
