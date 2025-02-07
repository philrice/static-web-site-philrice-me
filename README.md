# philrice-uk
[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/philrice/static-web-site-philrice-me)



Repository containing the code for the www.philrice.me blog.

## MkDocs - Static Web Site Generation

The site is generated from markdown files using the MkDocs static site generator. MkDocs converts the markdown into HTML and builds a working site with the required CSS, JS, and other supporting features like site search.

[![Built with Material for MkDocs](https://img.shields.io/badge/Material_for_MkDocs-526CFE?style=for-the-badge&logo=MaterialForMkDocs&logoColor=white)](https://squidfunk.github.io/mkdocs-material/)

### Installation / Local Testing

First clone this repo to your local environment and open in vscode, or you can also open in Github Codespaces or as a devcontainer from vscode
The devcontainer config in this repo includes all the dependencies needed.

Install MkDocs using pip:

```sh
pip install mkdocs
```

### Usage



To serve the site locally, use:

```sh
mkdocs serve
```

This will serve the site on localhost so you can make change and see them loaded in realtime.

To build the site, run:

```sh
mkdocs build
```

NB. It is not required to build the site as the GitHb Workflow has a job that will build the site and commit the updated code to the site directory in the repo, before then deploying to the Azure Static Web Site. This does mean that the site directory content is then new so you will need to git pull before pushing any new commits to avoid errors.

### Azure Configuration & Authentication

Ensure you have the necessary Azure credentials and permissions to deploy the resources. You can configure the Azure CLI, log in and set the subscription that will be targeted using:

```sh
az login
az account set --subscription "<subscription ID>"
```
You can also use other methods to authenticate such as via an app registration or federated workload identity in azure. You will need to adjust `providers.tf` to use the method you want.


## Infrastructure

The site is hosted on an Azure Static Web App, which is deployed as Infrastructure as Code (IaC) using Terraform.

### Deployment

To deploy the site, cd into the `infrastructure` directory and follow these steps:

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

### CI/CD with GitHub Actions

In the `.github/workflows` directory there is a GitHub Actions workflow file `azure-staticwebapp.yaml` that will:
- run `mkdocs build` to build the site 
- build the deployment package and deploy the site code to the Azure Static Web App

## Creating Posts

Post should be written in markdown and saved in the `/docs/posts/` directory.

For each post you need to add some metadata that wll be used to control certain aspects  :

```
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