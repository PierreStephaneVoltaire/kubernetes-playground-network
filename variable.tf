variable "app_name" {
  type    = string
  default = "infra"
}
variable "tags" {
  type = map(string)
}
variable "domain_name" {
  type = string
}

variable "cluster_service_ipv4_cidr" {
  type = string
}
variable "vpc_public_subnet_cidr" {
  type    = list(string)
  default = []
}
variable "vpc_private_subnet_cidr" {
  type    = list(string)
  default = []
}
variable "vpc_private_secondary_subnet_cidr" {
  type    = list(string)
  default = []
}
variable "vpc_azs" {
  type    = list(string)
  default = []
}
variable "vpc_cdr" {
  type = string
}
variable "allowed_ips" {
  type = list(string)
}

variable "subscription_id" {
  type      = string
  sensitive = true
}