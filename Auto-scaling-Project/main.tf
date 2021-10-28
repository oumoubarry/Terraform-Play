provider "aws"{
  region =  var.aws_region
}

data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name  = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
resource "aws_vpc" "terra-vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "terra-vpc"

  }
}
  # creating the igw 
resource "aws_internet_gateway" "terra-igw" {
  vpc_id = aws_vpc.terra-vpc.id

  tags = {
    Name = "terra-igw"
  }
}

  #  Public subnet 
resource "aws_subnet" "terra-pub-sub" {
  vpc_id                  = aws_vpc.terra-vpc.id
  cidr_block              = element(var.pub_sub_cidr_block, count.index) 
  availability_zone       = element(var.az_number, count.index)
  count = length(var.pub_sub_cidr_block)
  map_public_ip_on_launch = true
  

  tags = {
    Name = "terra-${var.pub-subnet-rename}-${count.index}"
  }
}

  #  Route table for public subnet 
resource "aws_route_table" "terra-pub-rt" {
  vpc_id     = aws_vpc.terra-vpc.id

  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.terra-igw.id
    }

  tags = {
    Name = "terra-pub-rt"

  }


}

  # public route table association
resource "aws_route_table_association" "terra-pub-rt-association" {
  subnet_id      = element(aws_subnet.terra-pub-sub.*.id , count.index)
  route_table_id = aws_route_table.terra-pub-rt.id
  count = 2
}

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


resource "aws_launch_configuration" "as-launch_config" {
  name   = "as-launch_config"
  image_id      = data.aws_ami.amazon-linux-2.id
  instance_type = var.instance_type_map["qa"]
  security_groups    = [aws_security_group.terra-web-sg.id]
  key_name           = var.instance_key_pair
  associate_public_ip_address = true
  user_data = file("install_apache.sh")


  lifecycle {
    create_before_destroy = true
  }
}

# creating the autoscaling group
resource "aws_autoscaling_group" "terra-asg" {
  name                 = "terraform-asg-template"
  launch_configuration = aws_launch_configuration.as-launch_config.name
  desired_capacity = 2
  min_size             = 2
  max_size             = 4
  vpc_zone_identifier = aws_subnet.terra-pub-sub.*.id
  
}
resource "aws_instance" "pub-instance-sub1" {
  ami                         = data.aws_ami.amazon-linux-2.id
  availability_zone           = element(var.az_number, count.index)
  # instance_type               = var.aws_instance_type
  instance_type               = var.instance_type_map["qa"] 
  key_name                    = var.instance_key_pair
  associate_public_ip_address = true
  subnet_id                   = element(aws_subnet.terra-pub-sub.*.id , count.index)
  security_groups        = [aws_security_group.terra-web-sg.id]
  count = 1
  user_data = file("install_apache.sh")

  tags = {
    Name = "publicinstance-${count.index}"
  }

}
  