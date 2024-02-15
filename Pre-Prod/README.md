# Sommaire
- [Sommaire](#sommaire)
- [Introduction](#introduction)
- [Pré-requis](#pré-requis)
- [Lancement](#lancement)

# Introduction
Construction de l'infrastructure pour la Pré-Prod du projet MorningNews.

Ce code Terraform et Ansible va construire un Cluster Kubernetes sur Linode avec 3 machines ainsi qu'une machine Linode pour héberger la base de donnée MongoDB via un docker compose.

# Pré-requis 
- [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- [Terraform](https://developer.hashicorp.com/terraform/install)
- Un nom de domaine pour le HTTPS
- Un compte [Linode](https://www.linode.com/)
  - Un token Linode configurer pour nous permettre de configurer automatiquement l'infrastructure via Terraform

# Lancement
On commence par construire l'infrastructure via Terraform :
```
terraform apply
```
Une fois la tâche fini, nous allons lancer la commande `ansible-playbook` pour nous permettre d'automatiser le déploiement de la base de donnée MongoDB sur la machine Linode que Terraform vien de créer (en utilisant le fichier host que Terraform nous a construit automatiquement)

```
cp ansible.cfg.example ansible.cfg
export ANSIBLE_CONFIG=ansible.cfg
ansible-playbook -u root database-playbook.yml --private-key *cheminCleSSHlinode*
```
La machine MongoDB Pré-prod doit maintenant être prete

Il suffit de finir avec le script `https-script.sh` pour configurer le Cluster Kubernetes ainsi que son HTTPS et son monitoring
```
./https-script.sh
``` 
Il faut bien suivre les instructions donnée par le script pour configurer la connections par HTTPS avec le nom de domaine que l'on veux.