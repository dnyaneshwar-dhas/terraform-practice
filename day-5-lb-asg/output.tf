output "vpc_id"{
    value = aws_vpc.my_vpc.id
}

output "load_balancer_dns" {
  value = aws_lb.lb.dns_name
}