variable "app_name" {}
variable "ami_id" {}
variable "env" {}
variable "ec2_file" {}
variable "iam_role_name" {}
variable "key_pair" {}
variable "instance_type" {
  default = "t2.micro"
}
variable "subnet_id" {
  type = "list"
}
variable "availability_zone" {
  type = "list"
}
variable "tags" {
  description = "A mapping of tags to assign to the resource"
  default     = {}
}
variable "public_ip" {
  default = false
}
variable "number_of_instances" {
  default = 1
}
variable "default_sgroups" {
  type = "list"
}
