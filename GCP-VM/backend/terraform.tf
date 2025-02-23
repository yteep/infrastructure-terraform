terraform {
  required_version = "= 1.10.5"
  required_providers {
    google = {
        source = "hashicorp/google"
        version = "= 6.19.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.6.3"
    }
     tls = {
      source = "hashicorp/tls"
      version = "4.0.6"
    }
  }
   backend "local" {
    path = "./mystate/my_terraform.tfstate"
  }
}