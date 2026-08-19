output "grafana_url" {
  description = "Grafana URL"
  value       = "http://${aws_instance.grafana.public_ip}:3000"
}

output "instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.grafana.id
}

output "instance_public_ip" {
  description = "Public IP of EC2 instance"
  value       = aws_instance.grafana.public_ip
}