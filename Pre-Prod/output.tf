resource "local_file" "kubeconfig" {
  depends_on = [linode_lke_cluster.lke_cluster]
  filename   = "kube-config.yml"
  content    = base64decode(linode_lke_cluster.lke_cluster.kubeconfig)
}

locals {
  machine_names = [for name in linode_instance.Pre-Prod_database.*.label : name]
  machine_ip    = [for ip in linode_instance.Pre-Prod_database.*.ip_address : ip]
}

# Create a host file for ansible to use
resource "local_file" "ansible_host_file" {
  content  = <<EOT
%{for ip in linode_instance.Pre-Prod_database.*.ip_address}
[${local.machine_names[index(local.machine_ip, ip)]}]
${ip}
%{endfor}
EOT
  filename = "host"
}

resource "local_file" "kubernetes_dep-service_file" {
  content  = <<EOT
apiVersion: v1
kind: Service
metadata:
  name: morningnews
spec:
  type: ClusterIP
  ports:
    - port: 80
      targetPort: 3000
  selector:
    app: morningnews
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: morningnews
spec:
  replicas: 3
  selector:
    matchLabels:
      app: morningnews
  template:
    metadata:
      labels:
        app: morningnews
    spec:
      containers:
        - name: morningnews
          image: obadahaddad/morningnews:pre-prod
          imagePullPolicy: Always
          env:
            - name: CONNECTION_STRING
              value: "mongodb://admin:admin@${local.machine_ip[0]}:80/morningnews"
          ports:
            - containerPort: 3000
EOT
  filename = "morningnews-dep_service.yml"
}