module "ec2_instanceweb" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "web-instance"
  count = var.instance_count

  ami                    = data.aws_ami.amazon-linux-2.id
  instance_type          = var.instance_type_map["dev"]
  key_name               = var.instance_key_pair
  vpc_security_group_ids = [module.web_sg.security_group_id]
  subnet_id              = element(module.vpc.private_subnets, count.index)
  user_data = file("install_apache.sh")

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
