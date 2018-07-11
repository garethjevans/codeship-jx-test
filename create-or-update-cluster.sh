#!/bin/bash

set -euo pipefail

SA=~/.gke_sa.json

TERRAFORM_VERSION=0.11.7
KUBERNETES_VERSION=1.9.9
HELM_VERSION=2.9.1

function install_dependencies() {
	wget https://github.com/jenkins-x/jx/releases/download/v${JX_VERSION}/jx-linux-amd64.tar.gz
	tar xvf jx-linux-amd64.tar.gz

	mkdir -p ~/.jx/bin
	
	wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
	unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
	rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip
	mv terraform ~/.jx/bin
	
	wget https://storage.googleapis.com/kubernetes-release/release/v${KUBERNETES_VERSION}/bin/linux/amd64/kubectl
	chmod +x kubectl
	mv kubectl ~/.jx/bin

	wget https://storage.googleapis.com/kubernetes-helm/helm-v${HELM_VERSION}-linux-amd64.tar.gz
	tar xvf helm-v${HELM_VERSION}-linux-amd64.tar.gz
	rm helm-v${HELM_VERSION}-linux-amd64.tar.gz
	mv linux-amd64/helm ~/.jx/bin
}

function configure_environment() {
	echo ${GKE_SA_JSON} > ${SA}
	git config --global --add user.name "${GIT_USER}"
	git config --global --add user.email "${GIT_EMAIL}"
}

function apply() {
	./jx create terraform -c 'dev=gke' -b -o ${ORG} --gke-service-account ${SA}
}

install_dependencies
configure_environment
apply
