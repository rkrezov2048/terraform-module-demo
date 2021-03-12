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

output "public_sg" {
  value = [aws_security_group.main_sg["public"].id]
}

output "db_sg" {
  value = [aws_security_group.main_sg["rds"].id]
}

output "sg" {
  value = values(aws_security_group.main_sg)[*].id
}

output "sg_name" {
  value = values(aws_security_group.main_sg)[*].name
}

output "sg_name_and_id" {
  value = zipmap(values(aws_security_group.main_sg)[*].name, values(aws_security_group.main_sg)[*].id)
}