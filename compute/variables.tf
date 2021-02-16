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