provider "google" {
    project = var.PROJECT_ID
    region = "europe-west6"
    zone = "europe-west6-a"
}

terraform {
    backend "gcs" {
        prefix = "tfstate"
    }
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

resource "google_compute_instance" "vm_instance" {
  name = "terraform-instance"
  machine_type = "f1-micro"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }
  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
      
    }
  }
}

resource "google_compute_address" "vm_static_ip" {
  name = "terraform-static-ip"
}