output "EC2_public_ip" {
  description = "public Ip of Ec2 instance"
  value       = module.Ec2_infrastructure.EC2_public_ip
}