# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.47.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  subscription_id = "2xxxxxxxx0"
}

#Create ressource group
resource "azurerm_resource_group" "genieLog" {
  name     = "genieLog-ressources"
  location = "West Europe"

  tags = {
    Owner = "GenieLogiciel"
  }

}

//Create azure storage account
resource "azurerm_storage_account" "storageGenieLogiciel" {
  name                     = "storage1genielog"
  resource_group_name      = azurerm_resource_group.genieLog.name
  location                 = azurerm_resource_group.genieLog.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "Learning"
  }
}

//create virtuel network
resource "azurerm_virtual_network" "virtuelNet" {
  name                = "virtualNet1"
  location            = azurerm_resource_group.genieLog.location
  resource_group_name = azurerm_resource_group.genieLog.name
  address_space       = ["10.0.0.0/16"]

  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "10.0.2.0/24"
  }
}

resource "azurerm_resource_group" "GL" {
  name     = "example-resources"
  location = "West Europe"

  tags = {
    Owner = "Genielogiciel"
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                = "gl-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.GL.location
  resource_group_name = azurerm_resource_group.GL.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "VMssubnet"
  resource_group_name  = azurerm_resource_group.GL.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "nic" {
  name                = "example-nic"
  location            = azurerm_resource_group.GL.location
  resource_group_name = azurerm_resource_group.GL.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "vm" {
  name                = "GenieLog-vm"
  resource_group_name = azurerm_resource_group.GL.name
  location            = azurerm_resource_group.GL.location
  size                = "Standard_F2"
  admin_username      = "adminuserxxx"
  admin_password      = "PAssword1234!xxx"
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}

output "GL" {
  value = azurerm_resource_group.GL.name
}


//there is no storage
# output "storage" {
#   value = azurerm_resource_account.storage
# }


