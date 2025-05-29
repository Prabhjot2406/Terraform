/* output "ec2_public_ip" {
    value = aws_instance.testinstance.public_ip
}

output "ec2_public_dns" {
    value = aws_instance.testinstance.public_dns
}

output "ec2_private_ip" {
    value = aws_instance.testinstance.private_ip
}  */

output "ec2_public_ips" {
  description = "Public IPs of all EC2 instances"
  value = {
    for name, instance in aws_instance.testinstance :
    name => instance.public_ip
  }
}

output "ec2_public_dns" {
  description = "Public DNS names of all EC2 instances"
  value = {
    for name, instance in aws_instance.testinstance :
    name => instance.public_dns
  }
}

output "ec2_private_ips" {
  description = "Private IPs of all EC2 instances"
  value = {
    for name, instance in aws_instance.testinstance :
    name => instance.private_ip
  }
}
