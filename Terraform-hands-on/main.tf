resource "aws_vpc" "terra-vpc" {
  cidr_block           = "10.0.0.0/16"
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
resource "aws_subnet" "terra-pub-sub1" {
  vpc_id                  = aws_vpc.terra-vpc.id
  cidr_block              = var.pub_sub1_cidr_block 
  availability_zone       = var.az_number
  map_public_ip_on_launch = true

  tags = {
    Name = "terra-pub-sub1"
  }
}
  #  Private subnet 
resource "aws_subnet" "terra-priv-sub1" {
  vpc_id                  = aws_vpc.terra-vpc.id
  cidr_block              = var.priv_sub1_cidr_block 
  availability_zone       = var.az_number

  tags = {
    Name = "terra-priv-sub1"
  }
}
  #  Route table for private subnet 
resource "aws_route_table" "terra-priv-rt" {
  vpc_id = aws_vpc.terra-vpc.id

  tags = {
    Name = "terra-priv-rt"
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
resource "aws_route_table_association" "terra-pub-rt" {
  subnet_id      = aws_subnet.terra-pub-sub1.id
  route_table_id = aws_route_table.terra-pub-rt.id
}
  # private route association
resource "aws_route_table_association" "terra-priv-rt" {
  subnet_id      = aws_subnet.terra-priv-sub1.id
  route_table_id = aws_route_table.terra-priv-rt.id
}