output "target_group_arn" {
  value = aws_lb_target_group.main_tf.arn
}

output "endpoint" {
  value = aws_lb_target_group.main_lb.dns_name
}