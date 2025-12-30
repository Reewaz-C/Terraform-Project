resource "aws_vpc" "Three_TIER_VPC" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "EC2_VPC"
  }
}

######################### WEB TIER ####################################

resource "aws_subnet" "EC2_subnet_WEB" {
  vpc_id                  = aws_vpc.Three_TIER_VPC.id
  cidr_block              = var.WEB_subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name = "WEB_subnet_public"
  }
}

resource "aws_internet_gateway" "EC2_IGW" {
  vpc_id = aws_vpc.Three_TIER_VPC.id
  tags = {
    Name = "VPC_IGW"
  }
}

resource "aws_route_table" "WEB_public_route" {
  vpc_id = aws_vpc.Three_TIER_VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.EC2_IGW.id
  }
  tags = {
    Name = "WEB_public_route"
  }
}

resource "aws_route_table_association" "public-asso" {
  subnet_id      = aws_subnet.EC2_subnet_WEB.id
  route_table_id = aws_route_table.WEB_public_route.id
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"
}
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.EC2_subnet_WEB.id

  tags = {
    Name = "APP_NAT_Gateway"
  }
}

######################### APP TIER ####################################


resource "aws_subnet" "EC2_subnet_APP" {
  vpc_id = aws_vpc.Three_TIER_VPC.id
  cidr_block = var.APP_subnet_cidr
  availability_zone = var.availability_zone
  tags = {
    Name = "APP_subnet_private"
  }
}

resource "aws_route_table" "APP_private_route" {
  vpc_id = aws_vpc.Three_TIER_VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name = "APP_private_route"
  }
}  


resource "aws_route_table_association" "private-asso" {
  subnet_id = aws_subnet.EC2_subnet_APP.id
  route_table_id = aws_route_table.APP_private_route.id
}

resource "aws_db_subnet_group" "DB_subnet_group" {
  name       = "three-tier-db-subnet-group"
  subnet_ids = [aws_subnet.EC2_subnet_DB.id, aws_subnet.EC2_subnet_APP.id]
  tags = {
    Name = "DB Subnet Group"
  }
}
######################### DB TIER ####################################

resource "aws_subnet" "EC2_subnet_DB" {
  vpc_id = aws_vpc.Three_TIER_VPC.id
  cidr_block = var.DB_subnet_cidr
  availability_zone = var.availability_zone
  tags = {
    Name = "DB_subnet_private"
  }
}

resource "aws_route_table" "DB_private_route" {
  vpc_id = aws_vpc.Three_TIER_VPC.id
  tags = {
    Name = "DB_private_route"
  }
}


resource "aws_route_table_association" "DB-assoc" {
  subnet_id = aws_subnet.EC2_subnet_DB.id
  route_table_id = aws_route_table.DB_private_route.id
}