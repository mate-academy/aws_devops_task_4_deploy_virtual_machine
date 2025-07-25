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

# create a key pair 
resource "aws_key_pair" "deploy_key" {
  key_name   = "deployer-key"
  public_key = file(var.public_key_path)
}


# create an ec2 instance 

resource "aws_instance" "this" {
  ami           = data.aws_ami.this.id
  instance_type = "t2.micro"   # У регіоні (eu-north-1) інстанс типу t2.micro більше не входить у Free Tier
  associate_public_ip_address = true
  subnet_id = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name = aws_key_pair.deploy_key.key_name
  user_data = file(var.script_parh)


  tags = {
    Name = "mate-aws-grafana-lab"
  }
}