module "Ec2_infrastructure" {
  source             = "./module/EC2"
  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.subnet_cidr
  availability_zone  = var.az
  instance_type      = var.instance_type
}

module "S3_bucket" {
  source = "./module/S3"
  log_bucket_name    = var.log_bucket_name
  main_bucket_name   = var.main_bucket_name
}