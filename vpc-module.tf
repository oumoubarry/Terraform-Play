module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.78.0"
  name = "terraorb-${var.vpc_name}"
  cidr = var.vpc_cidr_block
  azs = var.vpc_availability_zones
  public_subnets = var.vpc_public_subnets
  private_subnets = var.vpc_private_subnets

  create_database_subnet_group           = var.vpc_create_database_subnet_group
  create_database_subnet_route_table     = var.vpc_create_database_subnet_route_table
  database_subnets = var.vpc_database_subnets

  single_nat_gateway  = var.vpc_enable_single_nat_gateway
  enable_nat_gateway = var.vpc_enable_nat_gateway
#   enable_single_nat_gateway_per_az = var.vpc_enable_single_nat_gateway_per_az

  enable_dns_support   = var.vpc_enable_dns_support
  enable_dns_hostnames = var.vpc_enable_dns_hostnames

  database_subnet_tags = {
      type = "database-subnets"
  }

  public_subnet_tags = {
      type = "public-subnets"
  }

  private_subnet_tags = {
      type = "private-subnets"
  }

  tags = {
      owner = "oumou"
      environment = "dev"
  }
  vpc_tags = {
      name = "vpc-dev"
  }
}