output "public-uri" {
  description = "ec2 public ip"
  value       = aws_instance.devops-ec2_1.public_ip
}
output "nginx-uri-uri" {
  description = "nginx uri"
  value       = "http://${aws_instance.devops-ec2_1.public_ip}"
}

