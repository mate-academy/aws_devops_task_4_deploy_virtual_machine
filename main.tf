# AMI datasource to get the AMI id for your ec2 instance
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

# create a key pair
resource "aws_key_pair" "grafana" {
  key_name = "grafana-key"

  public_key = file("~/.ssh/id_rsa.pub")
  tags = {
    Name = "mate-aws-grafana-lab"
  }
}

# create an EC2 instance and install Grafana on it
resource "aws_instance" "grafana" {
  ami                         = data.aws_ami.this.id
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.grafana.key_name
  associate_public_ip_address = true
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  user_data                   = file("install-grafana.sh")

  tags = {
    Name = "mate-aws-grafana-lab"
  }
}