terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.8"
    }
  }
  required_version = ">= 1.3.0"
}

output "domain_acm_certificate_arn" {
  value = aws_acm_certificate.wildcard.arn
}
