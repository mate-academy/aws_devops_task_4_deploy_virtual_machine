data "aws_ami" "this" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name = "name"
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

resource "aws_key_pair" "this" {
  key_name   = "aws-grafana-lab-key"
  public_key = file("~/.ssh/id_rsa.pub")

  tags = {
    Name = "mate-aws-grafana-lab"
  }
}

resource "aws_instance" "this" {
  ami           = data.aws_ami.this.id
  instance_type = "t2.micro"

  associate_public_ip_address = true
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]

  key_name = aws_key_pair.this.key_name

  tags = {
    Name = "mate-aws-grafana-lab"
  }

  user_data = file("./install-grafana.sh")

#    <<EOT
# #!/bin/bash
# wget -q -O gpg.key https://rpm.grafana.com/gpg.key
# sudo rpm --import gpg.key

# cat >/etc/yum.repos.d/grafana.repo<<EOL
# [grafana]
# name=grafana
# baseurl=https://rpm.grafana.com
# repo_gpgcheck=1
# enabled=1
# gpgcheck=1
# gpgkey=https://rpm.grafana.com/gpg.key
# sslverify=1
# sslcacert=/etc/pki/tls/certs/ca-bundle.crt
# EOL

# yum install grafana -y

# systemctl daemon-reload
# systemctl start grafana-server
# systemctl enable grafana-server.service

# EOT


}
