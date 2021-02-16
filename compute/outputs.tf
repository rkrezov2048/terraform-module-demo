# --- compute/outputs.tf ---

output "instance" {
  value = aws_instance.main_node[*]
  sensitive = true
}