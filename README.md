# www.philrice.me - Static Web Site Hosted Blog
[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/philrice/static-web-site-philrice-me)

Repository containing the code for the www.philrice.me blog that is a static website.

## MkDocs - Static Web Site Generation

The site is generated from markdown files using the MkDocs static site generator. MkDocs converts the markdown into HTML and builds a working site with the required CSS, JS, and other supporting features like site search.

[![Built with Material for MkDocs](https://img.shields.io/badge/Material_for_MkDocs-526CFE?style=for-the-badge&logo=MaterialForMkDocs&logoColor=white)](https://squidfunk.github.io/mkdocs-material/)

### Installation / Local Testing

First clone this repo to your local environment and open it in VS Code, or you can also open it in GitHub Codespaces or as a devcontainer from VS Code. The devcontainer config in this repo includes all the dependencies needed.

Install MkDocs using pip:

```sh
pip install mkdocs
```

### Usage

To serve the site locally, use:

```sh
mkdocs serve
```

This will serve the site on localhost so you can make changes and see them loaded in real-time.

To build the site, run:

```sh
mkdocs build
```

NB. It is not required to build the site locally as the GitHub Workflow has a job that will build the site and commit the updated code to the `site` directory in the repo, before then deploying to the Azure Static Web Site. This does mean that the `site` directory content is then new, so you will need to `git pull` before pushing any new commits to avoid errors.

## Azure Configuration & Authentication

The site is hosted on an Azure Static Web App, and the Terraform state file is stored in an Azure Storage Blob. Sensitive information, such as the storage account key, is securely stored in Azure Key Vault.

### Prerequisites

1. **Azure Subscription**: Ensure you have an active Azure subscription.
2. **Azure CLI**: Install the Azure CLI if not already installed. [Azure CLI Installation Guide](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
3. **Terraform**: Install Terraform. [Terraform Installation Guide](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Setting Up Azure Resources

1. **Create a Resource Group**:
    ```sh
    az group create --name <resource-group-name> --location <location>
    ```

2. **Create a Storage Account**:
    ```sh
    az storage account create --name <storage-account-name> --resource-group <resource-group-name> --location <location> --sku Standard_LRS
    ```

3. **Create a Storage Container**:
    ```sh
    az storage container create --name <container-name> --account-name <storage-account-name>
    ```

4. **Create an Azure Key Vault**:
    ```sh
    az keyvault create --name <keyvault-name> --resource-group <resource-group-name> --location <location>
    ```

5. **Store the Storage Account Key in Key Vault**:
    Retrieve the storage account key:
    ```sh
    az storage account keys list --account-name <storage-account-name> --resource-group <resource-group-name> --query [0].value -o tsv
    ```

    Store the key in Key Vault:
    ```sh
    az keyvault secret set --vault-name <keyvault-name> --name <secret-name> --value <storage-account-key>
    ```

### Configuring Terraform Backend

Update the `providers.tf` file to configure the Terraform backend to use the Azure Storage Blob and Key Vault:

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "<resource-group-name>"
    storage_account_name = "<storage-account-name>"
    container_name       = "<container-name>"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}
```

### Authentication

Authenticate with Azure using the CLI:

```sh
az login
az account set --subscription "<subscription-id>"
```

Alternatively, you can configure authentication using an app registration or federated workload identity. Update the `providers.tf` file to reflect your chosen method.

## Infrastructure

The site is hosted on an Azure Static Web App, which is deployed as Infrastructure as Code (IaC) using Terraform.

### Deployment

To deploy the site, navigate to the `infrastructure` directory and follow these steps:

1. Initialize Terraform:
    ```sh
    terraform init
    ```

2. Plan the deployment:
    ```sh
    terraform plan -var="keyvault_name=<keyvault-name>" -var="storage_account_name=<storage-account-name>"
    ```

3. Apply the deployment:
    ```sh
    terraform apply -var="keyvault_name=<keyvault-name>" -var="storage_account_name=<storage-account-name>"
    ```

### CI/CD with GitHub Actions

In the `.github/workflows` directory, there is a GitHub Actions workflow file `azure-staticwebapp.yaml` that will:
- Run `mkdocs build` to build the site.
- Build the deployment package and deploy the site code to the Azure Static Web App.

## Creating Posts

Posts should be written in markdown and saved in the `/docs/posts/` directory.

For each post, you need to add some metadata that will be used to control certain aspects:

```yaml
---
draft: false
date: 2025-02-06
authors: [philrice]
categories:
  - General
links:
  - posts/second-test.md
---
```

## Variables to Update

To use this repository for your own site, ensure you update the following in providers.tf :
- **Azure Subscription ID**: Replace `<subscription-id>` with your Azure subscription ID.
- **Storage Account Name**: Replace `<storage-account-name>` with your storage account name.
- **Container Name**: Replace `<container-name>` with your storage container name.
- **Key Vault Name**: Replace `<keyvault-name>` with your Key Vault name.

and make sure you have the storage account key in the key vault and have assigned required permissions to allow reading of key values for the identity that you will be using

To set the resource group, location and static web site app name you can edit them directly in main.tf or pass in via a .tfvars file or on the cli as arguments:

```hcl
resource_group_name  = "rg-static-web-app-blog"
location = "West Europe"
name = "my-static-web-app-blog"
```
N.B. You must ensure that the location you choose supports static web site apps, as only certain ones have this available.