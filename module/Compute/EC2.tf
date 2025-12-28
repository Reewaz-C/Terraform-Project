data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  owners = ["099720109477"]
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

