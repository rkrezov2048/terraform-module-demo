#  --- loadbalancer/main ----

resource "aws_lb" "main_lb" {
    name = "main-alb"
    subnets = var.public_subnets
    security_groups = [ var.public_sg ]
    idle_timeout = 400
  
}