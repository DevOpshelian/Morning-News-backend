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

resource "linode_firewall" "my_firewall" {
  label = "pre-prod-firewall"

  inbound {
    label    = "allow-http"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "80"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
  }
  inbound {
    label    = "allow-metric"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "9216"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
  }

  inbound {
    label    = "allow-https"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "443"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
  }
  inbound {
    label    = "allow-ssh"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "22"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
  }
  inbound_policy = "DROP"

  outbound {
    label    = "accept-http"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "80"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
  }

  outbound {
    label    = "accept-https"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "443"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
  }
  outbound {
    label    = "accept-ssh"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "22"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
  }
  outbound {
    label    = "accept-udp"
    action   = "ACCEPT"
    protocol = "UDP"
    ports    = "53"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
  }
  outbound {
    label    = "accept-mongodb"
    action   = "ACCEPT"
    protocol = "tcp"
    ports    = "27017"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
  }
  outbound_policy = "DROP"

  linodes = [linode_instance.Pre-Prod_database.id]
}

resource "linode_instance" "Pre-Prod_database" {
    label = "Pre-Prod_database"
    image = "linode/debian12"
    region = "fr-par"
    type = "g6-nanode-1"
    authorized_users = [ "ObadaHaddad" ]
    root_pass = "pre-prod_backend-database"

}

resource "linode_lke_cluster" "lke_cluster" {
  label       = "Pre_Production-test"
  k8s_version = "1.28"
  region      = "fr-par"

  pool {
    type  = "g6-standard-1"
    count = 3
  }
}