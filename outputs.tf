output "instance_public_ip" {
    value = aws_instance.grafana_instance
    sensitive = false
}

output "grafana_url" {
    value = "http://${aws_instance.grafana_instance.public_ip}:3000/"
    sensitive = false
}
