output "Instance_amazon_linux_2_public_ip" {
  description = "display public ip address info"
  value = aws_instance.pub-instance-sub1[*].public_ip
}

output "instance_amazon_linux_2_dns" {
  description = "display instance dnsinfo"
  value = aws_instance.pub-instance-sub1[*].public_dns
  
}