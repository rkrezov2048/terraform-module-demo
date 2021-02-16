# --- compute/outputs.tf ---

output "instance" {
  value     = aws_instance.main_node[*]
  sensitive = true
}

output "instance_port" {
  value = aws_lb_target_group_attachment.main-tf-attach[0].port
}