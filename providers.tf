provider "aws" {
  region = "ca-central-1"
  default_tags {
    tags = var.tags
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}


