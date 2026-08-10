output "instance_public_ip" {
    value     = aws_instance.grafana_server.public_ip
    sensitive = false
}

output "grafana_url" {
    value     = "http://${aws_instance.grafana_server.public_ip}:3000/"
    sensitive = false
}