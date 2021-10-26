  # Web security group
resource "aws_security_group" "terra-web-sg" {
  name        = "terra-web-sg"
  description = "allow web and ssh traffic"
  vpc_id      = aws_vpc.terra-vpc.id

  ingress {
      description = "HTTP traffic"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks  = ["0.0.0.0/0"]
    }
  ingress {
      description = "shh traffic"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks  = ["76.100.213.107/32"]
    }

  egress {
      from_port  = 0
      to_port    = 0
      protocol   = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }

  tags = {
    Name = "terra-web-sg"

  }
}