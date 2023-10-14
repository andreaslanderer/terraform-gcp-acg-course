module "network" {
  source = "terraform-google-modules/network/google"
  version = "7.4.0"
  network_name = "acg-terraform-vpc"
  project_id = var.PROJECT_ID
  subnets = []
}

variable "PROJECT_ID" {
    description = "The unique ID of your GCP project"
    default = "not_provided"
}

terraform {
    backend "gcs" {
        prefix = "tfstate"
    }
}

resource "google_project_service" "resource_manager_api" {
  project = var.PROJECT_ID
  service = "cloudresourcemanager.googleapis.com"
}

resource "google_project_service" "compute_api" {
  project = var.PROJECT_ID
  service = "compute.googleapis.com"
}

resource "google_project_service" "iam_api" {
  project = var.PROJECT_ID
  service = "iam.googleapis.com"
}

resource "google_project_service" "billing_api" {
  project = var.PROJECT_ID
  service = "cloudbilling.googleapis.com"
}