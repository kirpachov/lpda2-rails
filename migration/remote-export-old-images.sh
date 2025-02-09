#!/bin/bash

set -e

rm -rf /tmp/lpda-uploads.zip

time zip /tmp/lpda-uploads.zip -r /home/WebApp/uploads/

echo "zip is available at /tmp/lpda-uploads.zip"

sudo chmod a+rwx /tmp/lpda-uploads.zip