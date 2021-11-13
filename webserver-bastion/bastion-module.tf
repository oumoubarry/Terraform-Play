module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "bastion-instance"
#   instance_count = 1

  ami                    = data.aws_ami.amazon-linux-2.id
  instance_type          = var.instance_type_map["dev"]
  key_name               = var.instance_key_pair
  vpc_security_group_ids = [module.security-group2.security_group_id]
  subnet_id = module.vpc.public_subnets[1]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
