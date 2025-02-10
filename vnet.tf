resource "azurerm_resource_group" "rg" {
  name     = "${var.app_name}-resource-group"
  location = "Canada Central"
}

resource "azurerm_virtual_network" "aks_vnet" {
  name                = "${var.app_name}-vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = [var.vpc_cdr]
}

resource "azurerm_subnet" "aks_subnet_private" {
  name                 = "${var.app_name}-private-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  address_prefixes     = [var.vpc_private_subnet_cidr[0]]
}
resource "azurerm_subnet" "aks_subnet_public" {
  name                 = "${var.app_name}-public-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  address_prefixes     = [var.vpc_public_subnet_cidr[0]]
}

resource "azurerm_public_ip" "aks_public_ip" {
  name                = "${var.app_name}-public-ip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
}
output "aks_subnet_private_id" {
  value = azurerm_subnet.aks_subnet_private.id
}
output "aks_subnet_public_id" {
  value = azurerm_subnet.aks_subnet_public.id
}
output "aks_vnet_id" {
  value = azurerm_virtual_network.aks_vnet.id
}
output "aks_public_ip" {
  value = azurerm_public_ip.aks_public_ip.id
}
output "resource_group_id" {
  value = azurerm_resource_group.rg.id
}