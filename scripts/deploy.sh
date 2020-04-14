#!/bin/sh

set -ex
VALUES_FILE=$(pwd)/values.yaml

PRIVATE_SPHINX=$(cat $PRIVATE_KEY_CONTENT | base64 -w 0 )
PUBLIC_SPHINX=$(cat $PUBLIC_KEY_CONTENT | base64 -w 0 )

cat > $VALUES_FILE <<EOF

environment: production
nym:
  layer: 3
  location: europe-west3
  data:
    private_sphinx: |
      $PRIVATE_SPHINX
    public_sphinx: |
      $PUBLIC_SPHINX
EOF

cat ${VALUES_FILE}

/scripts/deploy.sh -t helm -c engineering -a "nym-mixnode w3f/nym-mixnode -f ${VALUES_FILE}"
