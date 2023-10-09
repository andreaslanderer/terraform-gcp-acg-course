# Purpose

This repository contains a simple GCP setup using Terraform.

# Getting started

## Requirements

Make sure you have the following software installed:
* Terraform installed
* GCP CLI installed 
* Service Account with **Project Editor** role assigned

## Local Setup

First of all, we need to tell terraform where to find the key to our service account.
We do so by setting the environment variable to point to the path:

```shell
export TF_VAR_PATH_TO_SERVICE_ACCOUNT_KEY="<path-to-your-file>"
echo $TF_VAR_PATH_TO_SERVICE_ACCOUNT_KEY
```

Next, we need to provide the project in which the resources are supposed to live:
```shell
export TF_VAR_PROJECT_ID="<your-project-id>"
echo $TF_VAR_PROJECT_ID
```

Before we can apply out Terraform scripts we need to enable some Google APIs:
* CLoud Resource Manager API (cloudresourcemanager.googleapis.com)
* Compute Engine API (compute.googleapis.com)
* Identity and Access Management API (iam.googleapis.com)
* Cloud Billing API (cloudbilling.googleapis.com) 

Initializing Terraform
```shell
terraform init
```

Deploy with Terraform
```shell
terraform apply
```