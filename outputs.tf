output "instance_public_ip" {
  description = "Public IP of the Grafana EC2 instance"
  value       = aws_instance.grafana.public_ip
}

output "grafana_url" {
  description = "Grafana URL"
  value       = "http://${aws_instance.grafana.public_ip}:3000/"
}

output "instance_id" {
  value = aws_instance.grafana.id
}
output "public_dns" {
  value = aws_instance.grafana.public_dns
}
