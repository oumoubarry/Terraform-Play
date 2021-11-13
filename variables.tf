
variable "aws_region" {
  description = "regions value"
  type        = string
}
variable "vpc_availability_zones" {
  description = "vpc azs"
  type        = list (string)
}

variable "vpc_cidr_block" {
  description = "vpc_network id"
  type        = string

}
variable "ingress_cidr_blocks" {
  type = list(string)
  
}

variable "vpc_name" {
  description = "vpc name"
  type = string
  
}
# variable "vpc_id" {
#   description = "vpc id"
#   type = string
  
# }


variable "vpc_public_subnets" {
  description = "vpc public subnets"
  type        = list(string)

}
variable "vpc_private_subnets" {
  description = "vpc private subnets"
  type        = list(string)

}
variable "vpc_database_subnets" {
  description = "vpc database subnets"
  type = list(string)
  
}
variable "vpc_create_database_subnet_route_table" {
  description = "create vpc database subnets route table"
  type = bool
  
}
variable "vpc_create_database_subnet_group" {
  description = "create vpc database subnets group"
  type = bool
  
}
variable "vpc_enable_nat_gateway" {
  description = "enable natgw"
  type = bool
  
}

variable "vpc_enable_single_nat_gateway" {
  description = "enable natgw in 1 vpc"
  type = bool
  
}

variable "vpc_enable_single_nat_gateway_per_az" {
  description = "enable natgw per az"
  type = bool
  
}

variable "vpc_enable_dns_support" {
  description = "enable dns support"
  type = bool
  
}

variable "vpc_enable_dns_hostnames" {
  description = "enable dns hostnames"
  type = bool
  
}
variable "instance_key_pair" {
  description = "available key pair"
  type = string
  
}

variable "instance_type_map" {
  description = "lists of possible instance types"
  type = map(string)

}
variable "instance_count" {
  description = "instance count"
  type = number
  
}