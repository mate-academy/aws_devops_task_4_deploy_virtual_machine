terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# ЦЕЙ БЛОК МАЄ БУТИ З РЕГІОНОМ us-east-1
provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_key_pair" "grafana_key" {
  key_name   = "grafana-key"
  public_key = var.public_key
}

resource "aws_instance" "grafana" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"  # ЗМІНИТИ на t3.micro
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name               = aws_key_pair.grafana_key.key_name
  associate_public_ip_address = true
  user_data              = file("${path.module}/install-grafana.sh")

  tags = {
    Name = "mate-aws-grafana-lab"
  }
}