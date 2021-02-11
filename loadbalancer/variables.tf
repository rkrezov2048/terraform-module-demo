# --- loadbalancer/variables ---

variable "public_subnets" {}
variable "public_sg" {
  type = list(any)
}

variable "tg_port" {}
variable "tg_protocol" {}
variable "vpc_id" {}
variable "lb_healthy_threshold" {}
variable "lb_unhealthy_threshold" {}
variable "lb_timeout" {}
variable "interval" {}