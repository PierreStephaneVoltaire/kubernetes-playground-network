module "vpc" {
  source                 = "terraform-aws-modules/vpc/aws"
  version                = "~> 5.0"
  name                   = "${var.app_name}-vpc"
  cidr                   = var.vpc_cdr
  azs                    = var.vpc_azs
  private_subnets        = concat(var.vpc_private_subnet_cidr, var.vpc_private_secondary_subnet_cidr)
  secondary_cidr_blocks  = var.vpc_private_secondary_subnet_cidr
  public_subnets         = var.vpc_public_subnet_cidr
  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false
  public_subnet_tags = {
    "kubernetes.io/subnets/public":var.app_name
  }
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}
locals {
  regions=toset([data.aws_region.current.name,"us-east-1"])
}

module "vpc_endpoints" {
  source = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  vpc_id = module.vpc.vpc_id
  create_security_group      = true
  security_group_name_prefix = "${var.app_name}-vpc-endpoints-"
  security_group_description = "VPC endpoint security group"
  security_group_rules = {
    ingress_https = {
      description = "HTTPS from VPC"
      cidr_blocks = flatten([module.vpc.vpc_cidr_block,module.vpc.vpc_secondary_cidr_blocks])
    }
  }

  endpoints = {
    s3 = {
      service             = "s3"
      private_dns_enabled = true
      service_type    = "Gateway"
    },
    ecr_api = {
      service             = "ecr.api"
      private_dns_enabled = true
      subnet_ids          = slice(module.vpc.private_subnets,3,6)
    },
    ecr_dkr = {
      service             = "ecr.dkr"
      private_dns_enabled = true
      subnet_ids          =slice(module.vpc.private_subnets,3,6)
    },

    logs = {
      service             = "logs"
      private_dns_enabled = true
      subnet_ids          = slice(module.vpc.private_subnets,0,3)
    },
    cloudtrail = {
      service             = "cloudtrail"
      private_dns_enabled = true
      subnet_ids          = slice(module.vpc.private_subnets,0,3)
    },
    ebs = {
      service             = "ebs"
      private_dns_enabled = true
      subnet_ids          = slice(module.vpc.private_subnets,0,3)
    },
  }

}
