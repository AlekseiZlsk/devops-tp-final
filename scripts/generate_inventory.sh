#!/bin/bash
echo "Recherche de la passerelle Windows..."
WIN_IP=$(grep nameserver /etc/resolv.conf | awk '{print $2}')
echo "Passerelle trouvée : $WIN_IP"

echo "Récupération des IPs via SSH natif..."
K3S_IP=$(ssh -i .vagrant/machines/k3s/virtualbox/private_key -p 2222 -o StrictHostKeyChecking=no vagrant@$WIN_IP "hostname -I 2>/dev/null" | awk '{print $2}' | tr -d '\r')
MON_IP=$(ssh -i .vagrant/machines/monitoring/virtualbox/private_key -p 2200 -o StrictHostKeyChecking=no vagrant@$WIN_IP "hostname -I 2>/dev/null" | awk '{print $2}' | tr -d '\r')

# Sécurité si la 2ème IP n'est pas trouvée
if [ -z "$K3S_IP" ]; then K3S_IP=$(ssh -i .vagrant/machines/k3s/virtualbox/private_key -p 2222 -o StrictHostKeyChecking=no vagrant@$WIN_IP "hostname -I 2>/dev/null" | awk '{print $1}' | tr -d '\r'); fi
if [ -z "$MON_IP" ]; then MON_IP=$(ssh -i .vagrant/machines/monitoring/virtualbox/private_key -p 2200 -o StrictHostKeyChecking=no vagrant@$WIN_IP "hostname -I 2>/dev/null" | awk '{print $1}' | tr -d '\r'); fi

cat <<INVENTORY > ansible/inventory.ini
[k3s]
$K3S_IP ansible_user=vagrant ansible_ssh_private_key_file=.vagrant/machines/k3s/virtualbox/private_key ansible_ssh_common_args='-o StrictHostKeyChecking=no'

[monitoring]
$MON_IP ansible_user=vagrant ansible_ssh_private_key_file=.vagrant/machines/monitoring/virtualbox/private_key ansible_ssh_common_args='-o StrictHostKeyChecking=no'

[all:vars]
ansible_python_interpreter=/usr/bin/python3
INVENTORY

echo "Inventaire généré avec succès ! Voici son contenu :"
cat ansible/inventory.ini
