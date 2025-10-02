output "instance_public_ip" {
    value = aws_instance.mate_aws.public_ip
    sensitive = false
}

output "grafana_url" {
    value = "http://${aws_instance.mate_aws.public_ip}:3000/"
    sensitive = false
}
