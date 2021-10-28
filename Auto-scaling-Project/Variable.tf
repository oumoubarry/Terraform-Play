  # region variable
variable "aws_region" {
  description = "regions value"
  type        = string
  default     = "us-east-2"
}
variable "az_number" {
  description = "az value"
  type        = list (string)
  default     = ["us-east-2a", "us-east-2b"]
}

  # cvp cidr block variable
variable "vpc_cidr_block" {
  description = "vpc_network id"
  type        = string
  default     = "10.0.0.0/16"
}

  # public subnet cidr block variable
variable "pub_sub_cidr_block" {
  description = "vpc_network id"
  type        = list(string)
  default     =["10.0.0.0/24", "10.0.1.0/24"]
}
  # instance type variable
variable "aws_instance_type" {
  description = "instance type"
  type        = string
  default     = "t2.micro"
}
  # instance key pair variable
variable "instance_key_pair" {
  description = "instance type"
  type        = string
  default     = "Ansible-Ohio-KP" 
}
variable "instance_type_map" {
  description = "lists of possible instance types"
  type = map(string)
  default = {
    "dev" = "t2.small"
    "qa" = "t2.micro"
    "prod" = "t2.large"
  }
  
}
# variable to remane subnet using string interpolation
variable "pub-subnet-rename" {
    description = "renaming public subnet"
    type = string
    default = "pub-subnet"
}

#  variable to rename instance using string interpolation
variable "asg-ec2-name" {
    description = "renaming pub-instance-sub1"
    type = string
    default = "publicinstance"
}