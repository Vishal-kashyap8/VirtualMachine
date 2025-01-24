
resource "azurerm_resource_group" "DevOps1" {
    name = local.ResourceGroup
    location = local.Location
}
/**
resource "azurerm_storage_account" "appstorage" {
    name = "str24122024"
    resource_group_name = local.ResourceGroup
    location = local.Location
    account_tier = "Standard"
    account_replication_type = "LRS"
  depends_on = [ azurerm_resource_group.AssigmentRG ]
}

resource "azurerm_storage_container" "folders" {
  for_each = toset(["data","logs","scripts"])
  name                  = each.key
  storage_account_name = "str24122024"
  
  depends_on = [ azurerm_storage_account.appstorage ]
}



resource "azurerm_virtual_network" "AppNetwork" {

  name = local.virtual_network.name
  resource_group_name = azurerm_resource_group.AssigmentRG.name
  location = local.Location
  address_space = local.virtual_network.address_prefixex

}

resource "azurerm_subnet" "appsubnets" {
  for_each = {
   websubnet02 = ["10.1.1.0/24"]
   websubnet01 = ["10.1.2.0/24"]
  }
  name = each.key
  resource_group_name = azurerm_resource_group.AssigmentRG.name
  virtual_network_name = azurerm_virtual_network.AppNetwork.name
  address_prefixes = each.value
}

resource "azurerm_network_interface" "AppNIC" {
  count = 2
  name = "webinterface0${coun.index+1}"
  resource_group_name = azurerm_resource_group.AssigmentRG.name
  location = local.Location

  ip_configuration {
    name = "internal"
    subnet_id = azurerm_subnet.appsubnets["websubnet02"].id
    private_ip_address_allocation = "Dynamic"

  }
}

**/

#Working Script for VM

resource "azurerm_virtual_network" "prodVnet" {
  name                = "prodVnet"
  address_space       = ["10.0.0.0/16"]
  location            = local.Location
  resource_group_name = azurerm_resource_group.DevOps1.name
}

resource "azurerm_subnet" "prod-sub1" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.DevOps1.name
  virtual_network_name = azurerm_virtual_network.prodVnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "wm_nic_prod" {
  name                = "wm_nic_prod"
  location            = local.Location
  resource_group_name = azurerm_resource_group.DevOps1.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.prod-sub1.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "sqlwin01" {
  name                = "sqlwin01"
  resource_group_name = azurerm_resource_group.DevOps1.name
  location            = local.Location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "Wipro@12345678"
  network_interface_ids = [
    azurerm_network_interface.wm_nic_prod.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}