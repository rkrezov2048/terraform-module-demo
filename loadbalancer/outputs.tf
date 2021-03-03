output "target_group_arn" {
  value = aws_lb_target_group.main_tf.arn
}

output "endpoint" {
  value = aws_lb.main_lb.dns_name
}

output "alb_id" {
  value = aws_lb.main_lb.id
}

output "alb_arn" {
  value = aws_lb.main_lb.arn
}