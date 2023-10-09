provider "google" {
    credentials = file(var.PATH_TO_SERVICE_ACCOUNT_KEY)
    project = var.PROJECT_ID
    region = "europe-west6"
    zone = "europe-west6-a"
}

variable "PATH_TO_SERVICE_ACCOUNT_KEY" {
    description = "The path to the service account key file"
    default = "not_provided"
}

variable "PROJECT_ID" {
    description = "The unique ID of your GCP project"
    default = "not_provided"
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

resource "google_compute_network" "vpc_network" {
    name = "acg-terraform-vpc"
    depends_on = [ 
        google_project_service.resource_manager_api,
        google_project_service.compute_api,
        google_project_service.iam_api,
        google_project_service.billing_api
    ]
}