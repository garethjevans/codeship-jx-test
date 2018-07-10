#!/bin/bash

set -euo pipefail

JX_VERSION=1.3.76

function install_dependencies() {
	wget https://github.com/jenkins-x/jx/releases/download/v${JX_VERSION}/jx-linux-amd64.tar.gz
	tar xvf jx-linux-amd64.tar.gz
}

function configure_environment() {
#	echo $GKE_SA_JSON > ~/.gke_sa.json
}

function apply() {
	./jx version
}

install_dependencies
configure_environment
apply
