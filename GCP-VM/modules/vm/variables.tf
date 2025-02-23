variable "instance_name" {
  default = "test-vm-01"
}

variable "instance_type" {
  default = "e2-medium"
}

variable "region" {
  default = "us-central1"
}

variable "zone" {
  default = "us-central1-f"
}

# Your GCP project ID
variable "project" {
  default = "tf-deployments"
}

# The location where the service account key has been saved.
variable "local_gcp_path" {
  default = "/home/gcp/"
}

variable "gcp_api" {
  type = list(string)
  default = ["iam.googleapis.com", "cloudresourcemanager.googleapis.com","compute.googleapis.com"]
}