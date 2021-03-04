# --- outputs/ecs ----

output "cluster_id" {
  value = aws_ecs_cluster.dev-ecs1.id
}