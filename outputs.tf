output "ec2_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.web.public_ip
}
output "alb_dns_name" {
  description = "DNS of Application Load Balancer"
  value       = aws_lb.smartblog_alb.dns_name
}
