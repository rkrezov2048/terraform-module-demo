output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_sub" {
  value = aws_subnet.main_public.*.id
}

output "private_sub" {
  value = aws_subnet.main_private.*.id
}

output "db_subnet_group" {
  value = aws_db_subnet_group.main_rds_subg.*.name
}

# issue with hard codeded values for the output of the security group

output "alb_sg" {
  value = [aws_security_group.main_sg["alb_ecs"].id]
}

output "public_sg" {
  value = [aws_security_group.main_sg["public"].id]
}