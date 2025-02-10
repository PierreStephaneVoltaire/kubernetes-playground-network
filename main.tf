terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.8"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.18.0"
    }
  }
  required_version = ">= 1.3.0"
}

output "domain_acm_certificate_arn" {
  value = aws_acm_certificate.wildcard.arn
}

output "vpc_id" {
  value = module.vpc.vpc_id
}
output "private_subnets" {
  value = module.vpc.private_subnets
}
output "public_subnets" {
  value = module.vpc.public_subnets
}
output "allowed_ips" {
  value = var.allowed_ips
}
output "default_sg" {
  value = module.vpc.default_security_group_id
}
output "azs" {
  value = module.vpc.azs
}
output "secondary_subnets" {
  value = module.vpc.vpc_secondary_cidr_blocks
}