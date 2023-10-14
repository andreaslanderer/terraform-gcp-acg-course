module "network" {
  source = "terraform-google-modules/network/google"
  version = "7.4.0"
  network_name = "acg-terraform-vpc"
  project_id = var.project_id
  subnets = [
    {
      subnet_name = "subnet-public"
      subnet_ip = var.cidr_public
      subnet_region = var.region
    },
    {
      subnet_name = "subnet-private"
      subnet_ip = var.cidr_private
      subnet_region = var.region
      google_private_access = true
    }
  ]
}

module "network_fabric-net-firewall" {
  source = "terraform-google-modules/network/google//modules/fabric-net-firewall"
  version = "7.4.0"
  project_id = var.project_id
  network = module.network.network_name
  internal_ranges_enabled = true
  internal_ranges = [var.cidr_public]
}

module "network_routes" {
  source = "terraform-google-modules/network/google//modules/routes"
  version = "7.4.0"
  project_id = var.project_id
  network_name = module.network.network_name
  routes = [
    {
      name = "egress-internal"
      description = "Route through IGW to access internet"
      destination_range = "0.0.0.0/0"
      tags = "egress-inet"
      next_hop_internet = "true"
    }
  ]
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