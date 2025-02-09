#!/bin/bash

set -e

REMOTE_HOST="laportadacqua.com"

# From migration folder
rm -rf uploads.zip home && \
  mkdir -p images && \
  scp remote-export-old-images.sh $REMOTE_HOST:/tmp/ && \
  ssh -t $REMOTE_HOST "sudo -S chmod +x /tmp/remote-export-old-images.sh && sudo -S /tmp/remote-export-old-images.sh" && \
  time scp $REMOTE_HOST:/tmp/lpda-uploads.zip uploads.zip && \
  unzip uploads.zip && \
  mv home/WebApp/uploads/* images/ && \
  rm -rf home uploads.zip && \
  ssh -t $REMOTE_HOST "sudo -S rm -rf /tmp/lpda-uploads.zip /tmp/lpda-uploads /tmp/remote-export-old-images.sh"