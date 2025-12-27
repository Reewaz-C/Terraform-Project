module "Ec2_infrastructure" {
  source             = "./module/EC2_s3_child"
  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.subnet_cidr
  availability_zone  = var.az
  instance_type      = var.instance_type
  log_bucket_name    = var.log_bucket_name
  main_bucket_name   = var.main_bucket_name
}
