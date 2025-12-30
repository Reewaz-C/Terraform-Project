######################### WEB SG ####################################

resource "aws_security_group" "WEB_SG" {
  name   = "WEB_SG"
  vpc_id = var.vpc_id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
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
    Name = "WEB_SG"
  }
}

######################### APP TIER ####################################

resource "aws_security_group" "APP_SG" {
  name   = "APP_SG"
  vpc_id = var.vpc_id
  ingress {
    description     = "Traffic from WEB tier"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.WEB_SG.id]
  }
  ingress {
    description     = "SSH from WEB tier or Bastion host"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.WEB_SG.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "APP_SG"
  }
}

######################### DB TIER ####################################

resource "aws_security_group" "DB_SG" {
  name   = "DB_SG"
  vpc_id = var.vpc_id
  ingress {
    description     = "DB access from APP tier"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.APP_SG.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "DB_SG"
  }
}
