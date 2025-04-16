# Uncomment the ami datasource to get the AMI id for your ec2 instance: 
data "aws_ami" "this" {
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

resource "aws_key_pair" "ssh-key" {
  key_name   = "task4-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDZGezCae94DKfFNXmF0tDzP40OqnmMBAter1vgJaG5pnJPW6nevhXVfip0XfFcrv6E9HhHJVHOLdCvQNIm+H1kHnR1OZ3bRTcR3XmfecXiECx7v9lD/6AT+vXE6iBuEp4lImITOldZUQaADK+6rq7tmgxQI9M7dmUekTa0OR6IixdSC48ZYKMB3ZSQAxkZWYnIksA7ywc4HD4d3cjMT1kS4hqZkW+RbY4hSyzmN0gKu8uvrGeddgxXbjIRR2pco3VLKrqFsJCeiqAsMo04Fg5pDly48N+HcfsOh1h39L31WSVXAWwN2bXTLcms4n0SEU2UvYMrbRAwSCLu4mYcfFunACHwN45Z+YlAa8iCgyPlQ+XXgwGTfooPqOYpUKbwaIDEavweCQoHFMEhOqQItkOJhG7RZs3KAnxTYwPi1BwT5kcFoEOnF3NJA+e7gZLtehZu0AM+aW63mP3Ei7eyxvO2yjCPIw4/uWOy57e1TGyaxDqxaF1l9ZY4vJobt1PwM5Xwm7zx6jsKnswPzUFI7dJK6L3UdYtCxV7bUF5v6eRjYH/Y690p/my/U5aqN2tcJnCKlr7gpdM/EhL5VYtr1e1vsbjFZjUk1QfxR2fnwNRWSh7zEnMiISMDMqTA+dAc6ZL0yJaG416smboRFkPfqnAdIYX02DCTmA109Phw2AKIPQ== aws-task4"
}

resource "aws_instance" "this" {
  ami                         = data.aws_ami.this.id
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  key_name                    = aws_key_pair.ssh-key.key_name
  user_data = file("install-grafana.sh")

  tags = {
    Name = "mate-aws-grafana-lab"
  }
}