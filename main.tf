# --- AMI for Amazon Linux 2 ---
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

# --- Key Pair (uses your local public key) ---
resource "aws_key_pair" "this" {
  key_name   = "grafana-key"
  public_key = file("${path.module}/grafana_key.pub")
}

# --- EC2 instance with Grafana installed via user_data ---
resource "aws_instance" "this" {
  ami                         = data.aws_ami.this.id
  instance_type               = "t2.micro"
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  associate_public_ip_address = true

  key_name  = aws_key_pair.this.key_name
  user_data = file("${path.module}/install-grafana.sh")

  tags = {
    Name = "mate-aws-grafana-lab"
  }
}
