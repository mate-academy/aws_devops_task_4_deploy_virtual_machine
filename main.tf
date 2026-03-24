# Uncomment the ami datasource to get the AMI id for your ec2 instance:
data "aws_ami" "linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDYmf9RefboNxShzSA8q80ZcBcV2yBGS3ejlnU+AuZ3Q62zgzRzmbAgvVSELvVd77TpQC/+6KyRQjOoU86tuNEVgZNrSJ5rLkrntExKCOb9mmhWKqquxSLkvPrG6HhnF/mjODERA0WxPe0ceYO2qX5W2WHonynEt2JpW3VArbFD0SkFM/zu4UySOEtTyQijYhQxGZ9+pGtWz1RQYTaYzetFN3g9L08P31ng1nrNs9FdYR50xmSkm+S8KsSR6gQTHF6F1OFxLL8APWL1/IJNf+xKDBLbFcjEPZnMvwkp04qjn3K/exHdLennInOmT0Z+Vnd4wqzXzRu+4LeQitiOJUAx+cZVLddolmHZU9hW+b5eBogdx3CozcFUUrZfhVIsJJFfZGbloDXXV8PlMOTWeDOU5/oA/9s3I0Vwls2FirSvP0M4MGo7/l6UfMM3F5GSwatrs5EXChrbQbl9Ru5FpMAx56v5VjClRwb0XhYZVCGCxYsbZaBRpE3YmfZhCkoA6Y2sk7578gnzEVDqWgPDiGGA+wpUuQVPiuuU9oX24QYrgxnq0m1834vgAOBUacfhQ6GKVGeuM6CJXciEh+x1gBkaAcf/D/8vF80cf50HNyExSDz8WgSsBWQa2KSMkHqP5hK2ZhoL6BtpEaWM5QeYGJ5z6cEq+7ghg9f3yzZEO7wxJQ== acernitro7@DESKTOP-DL5L0MS"
}

resource "aws_instance" "grafana" {
  ami                         = data.aws_ami.linux.id
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  key_name                    = aws_key_pair.deployer.key_name

  tags = {
    Name = "mate-aws-grafana-lab"
  }

  user_data = file("${path.module}/install-grafana.sh")
}
