# Configure the GCP provider.
provider "google" {
  project     = var.project
  region      = var.region
  zone        = var.zone
  credentials = "${var.local_gcp_path}tf-deployments-key.json"  # Service account credentials
}

# Enable necessary GCP APIs & services
resource "google_project_service" "api_and_service_enabler" {
  for_each = toset(var.gcp_api)

  service = each.key

  timeouts {
    create = "10m"
    update = "10m"
  }
}

locals {
  env = "dev"
}


data "google_compute_default_service_account" "default" {
  depends_on = [time_sleep.wait_until_enabling_api]
}

# Create a seperate service account for the VM
resource "google_service_account" "sa_ubuntu_vm" {
  depends_on = [time_sleep.wait_until_enabling_api]
  account_id   = "test-deployments-vm"
  display_name = "Service account for the VM"
}

# Assign a role to the service account
resource "google_service_account_iam_member" "gce-default-account-iam" {
  service_account_id = data.google_compute_default_service_account.default.name
  role               = "roles/iam.serviceAccountUser"
  member             = "serviceAccount:${google_service_account.sa_ubuntu_vm.email}"
}



# Generate ssh key-pair and save them locally
resource "tls_private_key" "ssh-keys" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "local_file" "instance_private_key" {
  content  = tls_private_key.ssh-keys.private_key_pem
  filename = "VmPrivateKey.pem"
}

resource "local_file" "instance-public-key" {
  content  = tls_private_key.ssh-keys.public_key_openssh
  filename = "${var.local_gcp_path}VmPublicKey.pub"
}

# Delay resource creation
resource "time_sleep" "wait_until_enabling_api" {
  depends_on = [google_project_service.api_and_service_enabler]
  create_duration = "2m"
}

# Create a GCP vm
resource "google_compute_instance" "test_vm" {
  depends_on = [time_sleep.wait_until_enabling_api]
  name         = var.instance_name
  machine_type = var.instance_type
  zone         = var.zone
  project      = var.project

  allow_stopping_for_update = true

  tags = ["tst-vm", "demo"]

  boot_disk {
    initialize_params {
      image = "ubuntu-2404-noble-amd64-v20250117"
      #size = "40GB"
      labels = {
        env = local.env
      }
    }
  }

  network_interface {
    network = "default"

    access_config {} # Ephemeral public IP
  }

  metadata = {
    runner   = "true"
    ssh-keys = "ubuntu:${tls_private_key.ssh-keys.public_key_openssh}"

  }
   
   # Configure persmission for the service account
   service_account {
    email  = google_service_account.sa_ubuntu_vm.email
    scopes = ["compute-rw"]
  }
  
  # Execute commands on the remote VM
  provisioner "remote-exec" {
    inline = [
      "sudo mkdir -p /home/yashash/bin",
      "sudo touch /home/yashash/bin/testfile"
    ]
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    host        = self.network_interface.0.access_config.0.nat_ip
    private_key = tls_private_key.ssh-keys.private_key_pem
  }
}