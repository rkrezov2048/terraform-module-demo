# --- loadbalancer/variables ---

variable "public_subnets" {}
variable "public_sg" {
  type = list(any)
}

variable "tg_port" {}
variable "tg_protocol" {}
variable "vpc_id" {}
variable "tg_path" {}
variable "tg_healthy_threshold" {}
variable "tg_unhealthy_threshold" {}
variable "tg_timeout" {}
variable "tg_interval" {}
variable "tg_matcher" {}
variable "listener_port" {}
variable "listener_protocol" {}