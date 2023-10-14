provider "google" {
  project = var.project_id
  region = var.region
  zone = var.zone
}

terraform {
  backend "gcs" {
    prefix = "tfstate"
  }
}

resource "google_project_service" "resource_manager_api" {
  project = var.project_id
  service = "cloudresourcemanager.googleapis.com"
}

resource "google_project_service" "compute_api" {
  project = var.project_id
  service = "compute.googleapis.com"
}

resource "google_project_service" "iam_api" {
  project = var.project_id
  service = "iam.googleapis.com"
}

resource "google_project_service" "billing_api" {
  project = var.project_id
  service = "cloudbilling.googleapis.com"
}

resource "google_compute_network" "vpc_network" {
  name = "acg-terraform-vpc-2"
}

resource "google_compute_instance" "vm_instance" {
  name = "acg-terraform-compute-instance"
  machine_type = "f1-micro"
  tags = ["web"]
  zone = var.zone
  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
  }
  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
      
    }
  }
}

resource "google_compute_firewall" "vpc_network_firewall" {
  name = "web-firewall"
  network = google_compute_network.vpc_network.name
  
  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports = [ "80", "8080", "1000-2000" ]
  }

  source_tags = [ "web" ]
  source_ranges = [ "0.0.0.0/0" ]
}