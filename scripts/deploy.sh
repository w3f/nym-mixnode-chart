#!/bin/bash
/scripts/deploy.sh -t helm -a "\
 --set nym.id=${NYM_ID}\
 nym-mixnode w3f/nym-mixnode"
