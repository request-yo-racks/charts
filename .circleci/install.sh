#!/bin/bash
set -euo pipefail

# Install Helm.
HELM_LATEST_VERSION="v2.9.1"
wget http://storage.googleapis.com/kubernetes-helm/helm-${HELM_LATEST_VERSION}-linux-amd64.tar.gz
tar -xvf helm-${HELM_LATEST_VERSION}-linux-amd64.tar.gz
sudo mv linux-amd64/helm /usr/local/bin
rm -f helm-${HELM_LATEST_VERSION}-linux-amd64.tar.gz
rm -rf linux-amd64

# Setup Helm.
helm init -c
