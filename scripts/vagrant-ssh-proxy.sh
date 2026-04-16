#!/bin/bash
# Script de traduction Ansible -> Vagrant Windows
host=$1
shift
# On execute vagrant.exe ssh avec le nom de la machine, 
# puis -- pour envoyer les commandes Ansible a l'interieur
exec vagrant.exe ssh "$host" -- "$@"
