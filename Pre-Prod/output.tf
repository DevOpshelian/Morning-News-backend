/*resource "local_file" "kubeconfig" {
  depends_on = [linode_lke_cluster.lke_cluster]
  filename   = "kube-config.yml"
  content    = base64decode(linode_lke_cluster.lke_cluster.kubeconfig)
}*/

locals {
  machine_names = [for name in linode_instance.Pre-Prod_database.*.label : name]
  machine_ip    = [for ip in linode_instance.Pre-Prod_database.*.ip_address : ip]
}

# Create a host file for ansible to use
resource "local_file" "file" {
  content  = <<EOT
%{for ip in linode_instance.Pre-Prod_database.*.ip_address}
[${local.machine_names[index(local.machine_ip, ip)]}]
${ip}
%{endfor}
EOT
  filename = "host"
}