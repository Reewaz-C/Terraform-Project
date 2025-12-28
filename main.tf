module "Ec2_infrastructure" {
  source             = "./module/EC2"
  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.subnet_cidr
  availability_zone  = var.az
  instance_type      = lookup(var.instance_type, terraform.workspace, "t3.micro")
}

