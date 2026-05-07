#!/bin/bash

# Couleurs pour la lisibilité
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}====================================================${NC}"
echo -e "${GREEN}      Lancement du Déploiement Complet DevOps       ${NC}"
echo -e "${BLUE}====================================================${NC}"

# 1. Vérification de la configuration SSH
if [ ! -f "ssh_config_vagrant" ]; then
    echo -e "${BLUE}[1/5] Génération de la configuration SSH...${NC}"
    vagrant.exe ssh-config > ssh_config_vagrant
fi

# 2. Installation Docker (Partie 2)
echo -e "${BLUE}[2/5] Installation de Docker sur tous les nœuds...${NC}"
for node in k3s monitoring; do
    scp.exe -F ssh_config_vagrant scripts/install_docker.sh $node:/home/vagrant/
    ssh.exe -F ssh_config_vagrant $node "bash /home/vagrant/install_docker.sh"
done

# 3. Installation K3s (Partie 4)
echo -e "${BLUE}[3/5] Installation de K3s sur le nœud maître...${NC}"
scp.exe -F ssh_config_vagrant scripts/install_k3s.sh k3s:/home/vagrant/
ssh.exe -F ssh_config_vagrant k3s "bash /home/vagrant/install_k3s.sh"

# 4. Installation Monitoring (Partie 5)
echo -e "${BLUE}[4/5] Installation du Monitoring (Prometheus/Exporter)...${NC}"
for node in k3s monitoring; do
    scp.exe -F ssh_config_vagrant scripts/install_monitoring.sh $node:/home/vagrant/
    ssh.exe -F ssh_config_vagrant $node "bash /home/vagrant/install_monitoring.sh"
done

# 5. Vérification finale
echo -e "${BLUE}[5/5] Vérification de l'état du cluster...${NC}"
ssh.exe -F ssh_config_vagrant k3s "kubectl get nodes"

echo -e "${GREEN}====================================================${NC}"
echo -e "${GREEN}      DÉPLOIEMENT TERMINÉ ET OPÉRATIONNEL !         ${NC}"
echo -e "${BLUE}====================================================${NC}"
#lala
