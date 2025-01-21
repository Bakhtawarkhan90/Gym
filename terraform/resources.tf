provider "aws" {
  region = "us-east-1"
}

resource "aws_default_vpc" "vpc" {
}

resource "aws_security_group" "sg" {
  name        = "gym"
  description = "Allow ssh inbound traffic"

  vpc_id = aws_default_vpc.vpc.id

  ingress {
    description = "Allowing SSH from terraform"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "gym"
  }
}

resource "aws_instance" "ec2" {
  ami           = "ami-04b4f1a9cf54c11d0"
  instance_type = "t2.micro"
  key_name      = "Bootcamp"

  vpc_security_group_ids = [aws_security_group.sg.id]  # Corrected reference to security group ID

  tags = {
    Name    = "gym"
    Volumes = "gym"
  }
}
