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

resource "google_compute_network" "vpc_network" {
    name = "acg-terraform-vpc"
}