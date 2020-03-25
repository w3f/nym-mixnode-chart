#!/bin/bash
node_selector="node-pool-1mkm"
internal_ip=$(kubectl get nodes -o wide | grep $node_selector | awk '{print $6}')
external_ip=$(kubectl get nodes -o wide | grep $node_selector | awk '{print $7}')

internal_ip=$(kubectl get nodes -o wide | awk 'NR>1' | awk '{print $6}')
external_ip=$(kubectl get nodes -o wide | awk 'NR>1' | awk '{print $7}')


/scripts/deploy.sh -t helm -a "\
 --set nym.id=${NYM_ID}\
 --set nym.host=$internal_ip\
 --set nym.port=$NYM_PORT\
 --set nym.announce=$external_ip\
 --set nym.announce=$NYM_LAYER\
 --set nym.announce=$NYM_LOCATION\
 nym-mixnode w3f/mixnode"
