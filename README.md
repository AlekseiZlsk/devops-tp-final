# TP Final DevOps 

Ce projet présente une infrastructure complète, automatisée et supervisée pour le déploiement d'une API REST Node.js.

## Structure du Projet
* `Vagrantfile` : Orchestration des VMs (K3s & Monitoring).
* `scripts/` : Scripts d'automatisation (K3s, Docker, Monitoring).
* `ansible/` : Playbooks de configuration.
* `.github/workflows/` : Pipeline CI/CD.
* `Dockerfile` : Conteneurisation optimisée de l'application.

---

## 1. Infrastructure (Partie 1)
L'infrastructure est composée de deux VMs Debian (Bullseye) déployées via **Vagrant** :
- **k3s-node-tp** (2Go RAM) : Héberge le cluster Kubernetes.
- **monitoring-node-tp** : Héberge la stack de supervision et le Runner CI/CD.

**Automatisation :**
- Récupération dynamique des IPs via `generate_inventory.sh`.
- Génération automatique de l'inventaire **Ansible** pour garantir l'idempotence.

---

## 2. Conteneurisation Optimisée (Partie 2)
L'application a été conteneurisée avec un **Dockerfile Multi-stage build** :
- **Stage 1 (Build)** : Installation des dépendances.
- **Stage 2 (Final)** : Utilisation d'une image **Alpine Linux** ultra-légère.
- **Bénéfices** : Taille d'image réduite au minimum et surface d'attaque limitée.
- **Docker Hub** : Image disponible sur `teemlyz/node-rest-api`.

---

## 3. Orchestration Kubernetes (Partie 3)
Déploiement sur le cluster **K3s** avec les fonctionnalités suivantes :
- **Base de données** : MySQL avec persistance des données via `PersistentVolumeClaim`.
- **Haute Disponibilité** : Configuration d'un **Horizontal Pod Autoscaler (HPA)** pour scaler l'API de 1 à 3 pods selon la charge CPU/RAM.
- **Sécurité** : L'API est exposée via un service `ClusterIP` (accessible uniquement en interne).

---

## 4. Pipeline CI/CD (Partie 4)
Mise en place d'une pipeline **GitHub Actions** déclenchée à chaque push sur la branche `main`.
- **Innovation** : Utilisation d'un **Runner Self-Hosted** installé sur la VM `monitoring`.
- **Avantage** : Sécurité accrue (pas d'ouverture de ports SSH sur le web) et déploiement direct sur l'infrastructure locale.

---

## 5. Monitoring & Observabilité (Partie 5)
Supervision complète de l'infrastructure :
- **Stack** : Prometheus + Grafana.
- **Collecte** : `node_exporter` installé sur tous les nœuds.
- **Visualisation** : Dashboard "Node Exporter Full" (ID: 1860) configuré pour afficher les métriques en temps réel des deux VMs.

---

## Guide de démarrage rapide

1. **Lancer l'infrastructure :**
   ```bash
   vagrant up