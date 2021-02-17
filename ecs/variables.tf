# --- variables/ecs ----

variable "lc_instance_type" {}
variable "lc_iam_instance_profile" {}
variable "lc_security_groups" {}
variable "lc_associate_public_ip_address" {}
variable "lc_user_data" {}


variable "asg_min_size" {}
variable "asg_max_size" {}
variable "asg_desired_capacity" {}
variable "asg_vpc_zone_identifier" {}