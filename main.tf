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


resource "aws_key_pair" "this" {
  key_name   = "aws_key"
  public_key = file("~/.ssh/id_ed25519.pub")
}

resource "aws_instance" "this" {
  ami           = data.aws_ami.this.id
  subnet_id = var.subnet_id

  instance_type = "t2.micro"
  associate_public_ip_address = true

  vpc_security_group_ids = [var.security_group_id]

  key_name = aws_key_pair.this.key_name

  user_data = file("./install-grafana.sh")

  tags = {
    Name = "mate-aws-grafana-lab"
  }
}