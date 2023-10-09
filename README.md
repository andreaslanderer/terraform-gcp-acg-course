# Purpose

This repository contains a simple GCP setup using Terraform.

# Getting started

## Requirements

Make sure you have the following software installed:
* Terraform installed
* GCP CLI installed 
* Service Account with **Project Editor** role assigned
* Since this project persists its state remotely, you need to create a **Cloud Storage** bucket containing an empty **tfstate** folder.

## Local Setup

First of all, we need to tell terraform where to find the key to our service account.
We do so by setting the environment variable to point to the path:

```shell
export $GOOGLE_CREDENTIALS="$(cat <path-to-your-file>)"
echo $$GOOGLE_CREDENTIALS
``

Next, we need to provide the project in which the resources are supposed to live:
```shell
export TF_VAR_PROJECT_ID="<your-project-id>"
echo $TF_VAR_PROJECT_ID
```

Initializing Terraform
```shell
terraform init -backend-config="bucket=<your-cloud-storage-name>"
```

Deploy with Terraform
```shell
terraform apply
```