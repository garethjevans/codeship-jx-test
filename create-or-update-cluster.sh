#!/bin/bash

set -euo pipefail

JX_VERSION=1.3.76

ORG=myorg03
SA=~/.gke_sa.json

function install_dependencies() {
	wget https://github.com/jenkins-x/jx/releases/download/v${JX_VERSION}/jx-linux-amd64.tar.gz
	tar xvf jx-linux-amd64.tar.gz
}

function configure_environment() {
	echo ${GKE_SA_JSON} > ${SA}
	cat ${SA}
	mkdir -p ~/.jx/organisations/organisation-${ORG}
    cp -R clusters ~/.jx/organisations/organisation-${ORG}

}

function apply() {
	./jx version
	./jx create terraform -c 'dev=gke' -b -o ${ORG} --gke-service-account ${SA}
}

install_dependencies
configure_environment
apply
