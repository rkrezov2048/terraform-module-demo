output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_sub" {
  value = aws_subnet.main_public.*.id
}