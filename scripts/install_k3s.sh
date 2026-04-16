#!/bin/bash
# Installation de K3s (version légère de Kubernetes)
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--write-kubeconfig-mode 644 --disable traefik" sh -s -

echo "Attente du démarrage de K3s (30 secondes)..."
sleep 30
