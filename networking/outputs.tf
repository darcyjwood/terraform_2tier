# networking outputs.tf

output "vpc_id" {
  value = aws_vpc.demo_vpc.id
}

output "public_sg" {
  value = aws_security_group.demo_public_sg.id
}

output "private_sg" {
  value = aws_security_group.demo_private_sg.id
}

output "web_sg" {
  value = aws_security_group.demo_web_sg.id
}

output "private_subnet" {
  value = aws_subnet.demo_private_subnet[*].id
}

output "public_subnet" {
  value = aws_subnet.demo_public_subnet[*].id
}