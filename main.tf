# Uncomment the ami datasource to get the AMI id for your ec2 instance: 
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
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCt52KEmmBgCxfYC4D0+5sVnc4fbpap0PagF9AtnD+hP2DxkU4KXhgd5e49htpBZClR7/ho9cV71aXXm/zSZqvwzlq2TTbo9Q77DSJkIjLlvtJchPVlfHmpS4NS/HCXUX6XXiHYVE6/2AwpVYCa0unrFsySGFJduZNrQNyRRLlTu2kyNP10g737HpwnWHipF5Z9DoJSMeKs8fDZVA6pRjcp1GNZDa4lvBZ2KOWuAVSApcAcU1sBoyJ6p7Q8hR2j3pdQ5YLEW4tJP+PHhrrvzqEDoJD0iVB6WpdEjMaXcDZI3FpE7dqWA92tVD8PSgA1TFKW+18H3CaIRC1U/BV+DTQA7lCk9h28keCVRHzL0CdF71cHYGiMIfgF5f8De0UE96UQKNrlB1DMDstxnT7NtX+fOsA3Mq1GJH0a1a1DuwGqRjWIbqJ5F9o08B5Iyi5MOo/ZDu3+ypOkCH6bHIil3Y6sFpVb8tWIRqZ1W5XhZleG7/biW2fJE70IHrQ8phpUeHRYEFrx/6aLBEI9wLXmBgZ9y2Xum1R10+/3QgOHRWTIMAytTz6toN5M6Ib2xo0ApPJQvPUOIp/V3N8DeAzwaFKHzXwpdSDHT0pdc8UJMw9cc6M+Co/tyCJACMIcQkbEV+yXPdKfvB7qzP8w7eSOhvXXVWC9UjGb4zWl58wqAON6tw== ivche@Mykhailo-comp"
}
# create an ec2 instance 
resource "aws_instance" "mate_aws" {
  ami = data.aws_ami.this.id

  instance_type = "t2.micro"
  associate_public_ip_address = true
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  key_name = aws_key_pair.deployer.key_name
  user_data = file("install-grafana.sh")

  tags = {
    Name = "mate-aws-grafana-lab"
  }
}