#!/bin/bash

set -euo pipefail

JX_VERSION=1.3.76
TERRAFORM_VERSION=0.11.7

function install_dependencies() {
	wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
	unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
	rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

	wget https://github.com/jenkins-x/jx/releases/download/v${JX_VERSION}/jx-linux-amd64.tar.gz
	ls -al
	tar xvf jx-linux-amd64.tar.gz
	ls -al
}

#function configure_environment() {
#	echo $GKE_SA_JSON > ~/.gke_sa.json
#}

function apply() {
	./jx version
}

install_dependencies
#configure_environment
apply
