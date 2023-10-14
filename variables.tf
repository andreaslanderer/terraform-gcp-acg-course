variable "project_id" {
    description = "The unique ID of your GCP project"
    default = "not_provided"
}

variable "region" {
  default = "europe-west3"
}

variable "zone" {
  default = "europe-west3-a"
}

variable "cidr" {
  default = "10.0.0.0/16"
}