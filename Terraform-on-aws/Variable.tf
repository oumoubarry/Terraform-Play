  # region variable
variable "aws_region" {
  description = "regions value"
  type        = string
#   default     = "us-east-1"
}
variable "az_number" {
  description = "az value"
  type        = string
#   default     = "us-east-1"
}

  # cvp cidr block variable
variable "vpc_cidr_block" {
  description = "vpc_network id"
  type        = string
  default     = "10.0.0.0/16"
}
  # public subnet cidr block variable
variable "pub_sub1_cidr_block" {
  description = "vpc_network id"
  type        = string
  default     = "10.0.0.0/24"
}
  # private subnet cidr block variable
variable "priv_sub1_cidr_block" {
  description = "vpc_network id"
  type        = string
  default     = "10.0.1.0/24"
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