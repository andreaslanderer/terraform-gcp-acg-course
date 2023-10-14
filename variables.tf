variable "project_id" {
    description = "The unique ID of your GCP project"
    default = "not_provided"
}

variable "region" {
  default = "us-east1"
}

variable "zone" {
  default = "us-east1-b"
}

variable "cidr_public" {
  default = "10.0.0.0/16"
}

variable "cidr_private" {
  default = "10.1.0.0/16"
}