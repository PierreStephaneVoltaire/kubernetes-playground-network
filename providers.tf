provider "aws" {
  region = "ca-central-1"
  default_tags {
    tags = var.tags
  }
}