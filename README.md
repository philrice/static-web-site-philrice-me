# philrice-uk
[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/philrice/static-web-site-philrice-me)



Repository containing the code for the philrice.uk blog.

## MkDocs - Static Web Site Generation

The site is generated from markdown files using the MkDocs static site generator. MkDocs converts the markdown into HTML and builds a working site with the required CSS, JS, and other supporting features like site search.

[![Built with Material for MkDocs](https://img.shields.io/badge/Material_for_MkDocs-526CFE?style=for-the-badge&logo=MaterialForMkDocs&logoColor=white)](https://squidfunk.github.io/mkdocs-material/)

### Installation / Local Testing

First clone this repo to your local environment and open in vscode, or you can also open in Github Codespaces or as a devcontainer from vscode

Install MkDocs using pip:

```sh
pip install mkdocs
```

### Usage

To create a new project, run:

```sh
mkdocs new my-project
cd my-project
```

To serve the site locally, use:

```sh
mkdocs serve
```

To build the site, run:

```sh
mkdocs build
```

## Infrastructure

The site is hosted on an Azure Static Web App, which is deployed as Infrastructure as Code (IaC) using Terraform.

### Deployment

To deploy the site, follow these steps:

1. Initialize Terraform:

    ```sh
    terraform init
    ```

2. Plan the deployment:

    ```sh
    terraform plan
    ```

3. Apply the deployment:

    ```sh
    terraform apply
    ```

### Azure Configuration

Ensure you have the necessary Azure credentials and permissions to deploy the resources. You can configure the Azure CLI, log in and set the subscription thhat will be targeted using:

```sh
az login
az account set --subscription "<subscription ID>"
```

### CI/CD with GitHub Actions

In the `.github/workflows` directory there is a GitHub Actions workflow file `azure-staticwebapp.yaml` that will deploy the site code to the Azure Static Web App