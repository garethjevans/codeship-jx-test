#!/bin/bash

set -euo pipefail

SA=~/.gke_sa.json

TERRAFORM_VERSION=0.11.7

function install_dependencies() {
	wget https://github.com/jenkins-x/jx/releases/download/v${JX_VERSION}/jx-linux-amd64.tar.gz
	tar xvf jx-linux-amd64.tar.gz

	mkdir -p ~/.jx/bin
	
	wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
	unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
	rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip
	mv terraform ~/.jx/bin
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
