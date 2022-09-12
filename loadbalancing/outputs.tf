#loadbalancing outputs.tf

output "elb" {
  value = aws_lb.demo_lb.id
}

output "lb_tg" {
  value = aws_lb_target_group.demo_tg.arn
}

output "lb_dns" {
  value = aws_lb.demo_lb.dns_name
}