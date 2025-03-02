module "vpc" {
  source                 = "terraform-aws-modules/vpc/aws"
  version                = "~> 5.0"
  name                   = "${var.app_name}-vpc"
  cidr                   = var.vpc_cdr
  azs                    = var.vpc_azs
  private_subnets        = concat(var.vpc_private_subnet_cidr, var.vpc_private_secondary_subnet_cidr)
  secondary_cidr_blocks  = var.vpc_private_secondary_subnet_cidr
  public_subnets         = var.vpc_public_subnet_cidr
  enable_nat_gateway     = false
  public_subnet_tags = {
    "kubernetes.io/subnets/public":var.app_name
  }
  private_subnet_tags = {
    "karpenter.sh/discovery": "${var.app_name}-cluster"
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
    }
  }

}
