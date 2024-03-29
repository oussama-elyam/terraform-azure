# Terraform with Azure

## Terraform Overview

Terraform is an Infrastructure as Code (IaC) tool used for building, changing, and versioning infrastructure efficiently. It enables users to define and provision infrastructure using a declarative configuration language.

## Terraform Architecture

Terraform follows a client-server architecture. The main components are:

- **Terraform CLI:** The command-line interface for running Terraform commands.
- **Configuration Files:** Written in HashiCorp Configuration Language (HCL), these files define the infrastructure and resources.
- **Providers:** Plugins that interact with APIs of infrastructure providers (e.g., AWS, Azure, GCP) to manage resources.
- **State File:** Maintains the state of the infrastructure, enabling Terraform to understand what has been created and track changes.

## Terraform Essential Commands

1. **terraform init:**
   Initializes a new or existing Terraform working directory. Downloads providers and initializes the backend.

2. **terraform plan:**
   Generates an execution plan describing what Terraform will do to reach the desired state.


3. **terraform apply:**
   Applies the changes required to reach the desired state of the configuration.


4. **terraform destroy:**
   Destroys the Terraform-managed infrastructure, effectively terminating all resources.


5. **terraform validate:**
   Validates the configuration files for syntax and other errors.

## Use Case Overview
This repository contains Terraform code to deploy resources in Microsoft Azure.

#### Virtual Machine Configuration

##### Network Interface (nic)

- **Name:** example-nic
- **Resource Group:** example-resources
- **Location:** West Europe
- **IP Configuration:**
  - **Name:** internal
  - **Subnet ID:** Reference to the subnet in gl-network

##### Windows Virtual Machine (vm)

- **Name:** GenieLog-vm
- **Resource Group:** example-resources
- **Location:** West Europe
- **Size:** Standard_F2
- **Admin Username & Password:** 
- **Network Interface ID:** Reference to the network interface (nic)
- **OS Disk:**
  - **Caching:** ReadWrite
  - **Storage Account Type:** Standard_LRS
- **Source Image Reference:**
  - **Publisher:** MicrosoftWindowsServer
  - **Offer:** WindowsServer
  - **SKU:** 2016-Datacenter
  - **Version:** latest
