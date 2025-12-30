module "VPC" {
  source            = "./module/VPC"
  vpc_cidr          = var.vpc_cidr
  WEB_subnet_cidr   = var.WEB_subnet_cidr
  APP_subnet_cidr   = var.APP_subnet_cidr
  DB_subnet_cidr    = var.DB_subnet_cidr
  availability_zone = var.availability_zone
}

module "SG" {
  source = "./module/SG"
  vpc_id = module.VPC.vpc_id
}

module "Web_compute" {
  source             = "./module/Compute"
  subnet_id          = module.VPC.WEB_subnet_id
  vpc_security_group_ids = [module.SG.web_sg_id]
  instance_type      = lookup(var.instance_type, terraform.workspace, "t3.micro")
  name               = "Web-Server"
}

module "App_compute" {
  source             = "./module/Compute"
  subnet_id          = module.VPC.APP_subnet_id
  vpc_security_group_ids = [module.SG.app_sg_id]
  instance_type      = lookup(var.instance_type, terraform.workspace, "t3.micro")
  name               = "App-Server"
}

module "DB_compute" {
  source         = "./module/DB"
  db_name        = var.db_name
  engine         = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class
  username       = var.username
  password       = var.password

  parameter_group_name = var.parameter_group_name
  skip_final_snapshot  = var.skip_final_snapshot

  vpc_security_group_ids   = [module.SG.db_sg_id]
  db_subnet_group_name = module.VPC.DB_subnet_group_name

}