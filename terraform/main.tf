terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "1.24.0"
    }
  }
}

provider "linode" {
  token = var.token
}


resource "linode_lke_cluster" "lke_cluster" {
  label       = "Production_test"
  k8s_version = "1.28"
  region      = "fr-par"

  pool {
    type  = "g6-standard-1"
    count = 2
  }
}