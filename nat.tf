

module "fck-nat" {
  source = "RaJiska/fck-nat/aws"
  name                 = "${var.app_name}-fck-nat"
  vpc_id               = module.vpc.vpc_id
  subnet_id            = module.vpc.public_subnets[0]
  instance_type        = "t4g.nano"
  use_spot_instances =true
  ha_mode              = true
  update_route_tables = true
  route_tables_ids = { for i, rt_id in module.vpc.private_route_table_ids : "private-${i}" => rt_id }
}