output "vpc_id" {
    description = "VPC ID for architecture"
    value = aws_vpc.Three_TIER_VPC.id
}

output "WEB_subnet_id" {
    description = "Subnet ID for Web Tier"
    value = aws_subnet.EC2_subnet_WEB.id
}

output "APP_subnet_id" {
    description = "Subnet ID for App Tier"
    value = aws_subnet.EC2_subnet_APP.id
}

output "DB_subnet_id" {
    description = "SUbnet ID for DB Tier"
    value = aws_subnet.EC2_subnet_DB.id
}

output "WEB_subnet_cidr" {
    description = "Subnet CIDR for WEB"
    value = aws_subnet.EC2_subnet_WEB.cidr_block
}

output "APP_subnet_cidr" {
    description = "Subnet CIDR for APP"
    value = aws_subnet.EC2_subnet_APP.cidr_block
}

output "DB_subnet_cidr" {
    description = "Subnet CIDR for DB"
    value = aws_subnet.EC2_subnet_DB.cidr_block
}

output "DB_subnet_group_name" {
  description = "DB Subnet Group Name for RDS"
  value       = aws_db_subnet_group.DB_subnet_group.name
}