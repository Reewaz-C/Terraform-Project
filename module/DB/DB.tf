data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  owners = ["099720109477"]
}

resource "aws_vpc" "EC2_VPC" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "EC2_VPC"
  }
}

resource "aws_subnet" "EC2_subnet" {
  vpc_id                  = aws_vpc.EC2_VPC.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name = "EC2-subnet"
  }
}

resource "aws_internet_gateway" "EC2_IGW" {
  vpc_id = aws_vpc.EC2_VPC.id
  tags = {
    Name = "VPC_IGW"
  }
}

resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.EC2_VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.EC2_IGW.id
  }
  tags = {
    Name = "public-route"
  }
}

resource "aws_route_table_association" "public-asso" {
  subnet_id      = aws_subnet.EC2_subnet.id
  route_table_id = aws_route_table.public_route.id
}

resource "aws_security_group" "EC2SG" {
  name   = "EC2SG"
  vpc_id = aws_vpc.EC2_VPC.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "EC2SG"
  }
}

resource "aws_instance" "server" {
  ami                    = data.aws_ami.ubuntu.id
  vpc_security_group_ids = [aws_security_group.EC2SG.id]
  subnet_id              = aws_subnet.EC2_subnet.id
  instance_type          = var.instance_type
  tags = {
    Name = "My-Server"
  }
}

