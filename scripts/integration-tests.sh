#!/bin/bash

source /scripts/common.sh
source /scripts/bootstrap-helm.sh
set -ex


run_tests() {
  echo Running tests...
  wait_pod_ready nym-mixnode default 1/1
}

teardown() {
  helm delete nym-mixnode
}

main(){
  echo Installing...
  helm install --set environment="ci" --set nym.id=${NYM_ID} --set nym.host=172.17.0.4 nym-mixnode ./charts/nym-mixnode

  run_tests

}

main
set +x
