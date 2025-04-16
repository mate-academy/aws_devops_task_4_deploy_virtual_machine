data "aws_ami" "this" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }

  filter {
    name = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_key_pair" "grafana_key" {
  key_name = "grafana-key-pair"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "grafana_instance" {
  ami = data.aws_ami.this.id
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.grafana_key.key_name
  subnet_id = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  associate_public_ip_address = true

  tags = {
    Name = "mate-aws-grafana-lab"
  }

  user_data = file("${path.module}/install-grafana.sh") # Loading the script file from the module path
}
