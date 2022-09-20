# root main.tf

module "compute" {
  source         = "./compute"
  public_sg      = module.networking.public_sg
  private_sg     = module.networking.private_sg
  private_subnet = module.networking.private_subnet
  public_subnet  = module.networking.public_subnet
  elb            = module.loadbalancing.elb
  lb_tg          = module.loadbalancing.lb_tg
  key_name       = "tf2t_project_east"
}

module "networking" {
  source        = "./networking"
  vpc_cidr      = "10.0.0.0/16"
  access_ip     = var.access_ip
  public_cidrs  = ["10.0.1.0/24", "10.0.3.0/24", "10.0.5.0/24"]
  private_cidrs = ["10.0.2.0/24", "10.0.4.0/24", "10.0.6.0/24"]
}

module "loadbalancing" {
  source        = "./loadbalancing"
  public_subnet = module.networking.public_subnet
  vpc_id        = module.networking.vpc_id
  web_sg        = module.networking.web_sg
  database_asg  = module.compute.database_asg
}

