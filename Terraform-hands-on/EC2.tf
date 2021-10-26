  # creating EC2  instance in the public subnet
resource "aws_instance" "pub-instance-sub1" {
  ami                         = data.aws_ami.amazon-linux-2.id
  availability_zone           = var.az_number
  # instance_type               = var.aws_instance_type
  instance_type               = var.instance_type_map["prod"] 
  key_name                    = var.instance_key_pair
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.terra-pub-sub1.id
  security_groups        = [aws_security_group.terra-web-sg.id]
  count = 3

  tags = {
    Name = "publicinstance-${count.index}"
  }
}
  # creating an EC2 instance in the private subnet
resource "aws_instance" "priv-instance-sub1" {
  ami                 = data.aws_ami.amazon-linux-2.id
  availability_zone   = var.az_number
  instance_type               = var.instance_type_map["prod"] 
  # instance_type       = var.aws_instance_type
  key_name            = var.instance_key_pair
  subnet_id           = aws_subnet.terra-priv-sub1.id
  security_groups = [aws_security_group.terra-web-sg.id]
  count = 3
  tags = {
    Name = "privateinstance-${count.index}"
  }

}   
