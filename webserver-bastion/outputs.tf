output "vpc" {
    description = "vpc id"
    value = module.vpc.vpc_id

}
output "security-group2" {
    description = "bastion security group id"
    value = module.security-group2.security_group_id
}
output "web_sg" {
    description = "web secutity group id"
    value = module.web_sg.security_group_id
  
}
