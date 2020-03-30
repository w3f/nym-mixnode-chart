#!/bin/bash
kubectl label nodes $NODE_SELECTOR nym=true

internal_ip=$(kubectl get nodes -o wide | grep $NODE_SELECTOR | awk '{print $6}')
external_ip=$(kubectl get nodes -o wide | grep $NODE_SELECTOR | awk '{print $7}')

/scripts/deploy.sh -t helm -a "\
 --set nym.id=${NYM_ID}\
 nym-mixnode w3f/nym-mixnode"
