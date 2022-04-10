output "vpc_id" {
  value = aws_vpc.main.id
}

output "default_security_group_id" {
  value = aws_vpc.main.default_security_group_id
}

output "private_subnet_ids" {
  value = [aws_subnet.first_private_az.id, aws_subnet.second_private_az.id]
}

output "public_subnet_ids" {
  value = [aws_subnet.first_public_az.id, aws_subnet.second_public_az.id]
}
