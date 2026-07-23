#!/bin/bash
set -e

# 1. Mettre à jour le système et installer Docker & Docker Compose
apt-get update -y
apt-get install -y ca-certificates curl gnupg lsb-release git

mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

systemctl start docker
systemctl enable docker

# 2. Cloner la stack Docker ChirpStack officielle
cd /home/ubuntu
git clone https://github.com/chirpstack/chirpstack-docker.git
cd chirpstack-docker

# 3. Lancer la stack ChirpStack au démarrage
docker compose up -d