# -- - compute/variables ----

variable "instance_count" {
  default = 1
}

variable "instance_type" {
  default = "t2.micro"
}

variable "public_sg" {}
variable "public_sub" {}
variable "vol_size" {}
variable "additional_tags" {}
variable "key_name" {}
variable "public_key_path" {}
variable "used_data_path" {}
variable "dbuser" {}
variable "db_endpoint" {}
variable "dbpass" {}
variable "dbname" {}
variable "target_group_arn" {}
variable "target_id" {}