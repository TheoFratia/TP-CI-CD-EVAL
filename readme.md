# Déploiement Continu API IoT – README

## Présentation
Ce projet met en place un pipeline CI/CD pour le déploiement d’une API Node.js sur Google Cloud Platforme, en utilisant Terraform, Ansible et GitHub Actions.

## Arborescence

```
Terraform-deploy/
├── credentials.json
├── rapport.md
├── Release.sh
├── ansible/
│   ├── deploy.yml
│   └── inventory.ini
├── api/
│   ├── index.js
│   └── package.json
└── infra/
    ├── main.tf
    ├── outputs.tf
    ├── terraform.tfstate
    ├── terraform.tfstate.backup
    └── variables.tf
```

## Fonctionnement

### 1. Provisionnement de l’infrastructure (Terraform)
- Décrit l’infrastructure dans `infra/main.tf`.
- Crée une VM Ubuntu avec IP publique.
- Les variables (`variables.tf`) permettent de personnaliser la région, le projet, la zone.
- L’output (`outputs.tf`) expose l’IP publique de la VM.

### 2. Déploiement de l’API (Ansible)
- Utilise un inventaire dynamique (`inventory.ini`) mis à jour avec l’IP de la VM.
- Le playbook (`deploy.yml`) :
  - Installe Node.js, npm, git
  - Clone le repo de l’API
  - Installe les dépendances npm
  - Installe PM2
  - Démarre l’API avec PM2
  - Expose les métriques Prometheus sur /metrics

### 3. Pipeline CI/CD (GitHub Actions)
- Déclenché à chaque push sur `main`.
- Étapes :
  - Checkout du code
  - Setup de Terraform et authentification GCP
  - Création du fichier `terraform.tfvars`
  - `terraform init` puis `terraform apply`
  - Récupération de l’IP publique de la VM
  - Mise à jour de l’inventaire Ansible
  - Exécution du playbook Ansible
  

## Screenshots

![Déploiement réussi](./result.png)

---

# Ce qu’il reste à faire

- **Monitoring & alerting** :
  - Ajouter une solution de monitoring (Prometheus) pour surveiller l’état de l’API et de l’infrastructure.
- **Rollback automatisé** :
  - Implémenter une stratégie de rollback automatique en cas d’échec du déploiement.
- snapshots/ : fichiers ou configuration de snapshot si applicabl@
- git/: Historique Git avec GitFlo
- tags/: Versionnement sémantique (ex: v1.0.0)

---
