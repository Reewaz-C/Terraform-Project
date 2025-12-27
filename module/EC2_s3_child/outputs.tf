output "region" {
  description = "AWS region"
  value       = var.region
}

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.EC2_VPC
}

output "instance_id" {
  description = "Id of instance"
  value       = aws_instance.server.id
}

output "EC2_public_ip" {
  description = "public Ip of Ec2 instance"
  value       = aws_instance.server.public_ip
}

output "log_bucket_name" {
  description = "Name of Log bucket"
  value       = aws_s3_bucket.logbucket.bucket
}

output "main_bucket_name" {
  description = "Name of Main bucket"
  value       = aws_s3_bucket.main_bucket.bucket
}