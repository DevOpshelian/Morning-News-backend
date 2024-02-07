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

resource "linode_instance" "Pre-Prod_database" {
    label = "Pre-Prod_database"
    image = "linode/debian12"
    region = "eu-central"
    type = "g6-nanode-1"
    authorized_users = [ "ObadaHaddad" ]
    root_pass = "pre-prod_backend-database"

}

/*resource "linode_lke_cluster" "lke_cluster" {
  label       = "Pre_Production-test"
  k8s_version = "1.28"
  region      = "eu-central"

  pool {
    type  = "g6-standard-1"
    count = 1
  }
}*/