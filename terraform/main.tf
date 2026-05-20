module "network" {
  source       = "./modules/network"
  app_port     = var.app_port
  my_public_ip = var.my_public_ip
}

module "compute" {
  source               = "./modules/compute"
  ami_id               = var.ami_id
  instance_type        = var.instance_type
  security_group_id    = module.network.security_group_id
  iam_instance_profile = var.iam_instance_profile
  app_port             = var.app_port
}