module "web_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "web-sg"
  description = "Security group for web server with custom ports open within VPC, and PostgreSQL publicly open"
  vpc_id      = module.vpc.vpc_id


  ingress_cidr_blocks      = var.ingress_cidr_blocks
  ingress_with_cidr_blocks = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "web-service ports"
      cidr_blocks = var.vpc_cidr_block
    },
    {
      from_port       = 22
      to_port = 22
      protocol = "tcp"
      description = "web-service ports"
      cidr_blocks = var.vpc_cidr_block
    },
  ]
}
