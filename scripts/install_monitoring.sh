#!/bin/bash

# 1. Node Exporter partout
echo "Installation de Node Exporter..."
sudo apt-get update && sudo apt-get install -y prometheus-node-exporter
sudo systemctl enable --now prometheus-node-exporter

# 2. Prometheus et Grafana uniquement sur le nœud monitoring
if [[ "$(hostname)" == *"monitoring"* ]] || [[ "$(hostname)" == *"bullseye"* && "$(ip addr)" == *"192.168.56.6"* ]]; then
    echo "Installation de Prometheus..."
    sudo apt-get install -y prometheus
    sudo systemctl enable --now prometheus

    echo "Installation de Grafana..."
    sudo apt-get install -y apt-transport-https software-properties-common wget
    sudo mkdir -p /etc/apt/keyrings/
    wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null
    echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee /etc/apt/sources.list.d/grafana.list
    
    sudo apt-get update
    sudo apt-get install -y grafana
    sudo systemctl enable --now grafana-server
fi
