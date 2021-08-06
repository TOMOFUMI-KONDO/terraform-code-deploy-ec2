output "alb_public_domain" {
  value = aws_lb.main.dns_name
}

output "ec2_public_ip" {
  value = aws_instance.ec2.public_ip
}

output "ec2_id" {
  value = aws_instance.ec2.id
}
