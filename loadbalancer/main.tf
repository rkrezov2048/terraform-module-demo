#  --- loadbalancer/main ----

resource "aws_lb" "main_lb" {
  name            = "main-alb"
  subnets         = var.public_subnets
  security_groups = var.public_sg
  idle_timeout    = 400

}


resource "aws_lb_target_group" "main-tf" {
  name     = "main-lb-tg-${substr(uuid(), 0, 4)}"
  port     = var.tg_port     #80
  protocol = var.tg_protocol #HTTP
  vpc_id   = var.vpc_id
  #   make this dynamic for multiple target groups
  health_check {
    healthy_threshold   = var.lb_healthy_threshold   
    unhealthy_threshold = var.lb_unhealthy_threshold 
    timeout             = var.lb_timeout             
    interval            = var.interval               
  }
}