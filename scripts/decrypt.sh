#!/bin/bash

# Usage (from the root of the project):
# ENCRYPTION_PASSWORD="<pwd>" ./scripts/decrypt.sh <file_path> [<output_filename>]
#
# Example:
# ENCRYPTION_PASSWORD="Ciao" ./scripts/decrypt.sh scripts/encrypt.sh.enc encrypted.sh
# Note: File will be decrypted in the same directory as the original file

FILE_PATH="${1?Please provide the file to decrypt}"
ENCRYPTION_PASSWORD="${ENCRYPTION_PASSWORD?Please provide ENCRYPTION_PASSWORD to decrypt the file}"

WORKING_DIR=$(dirname $FILE_PATH)
FILE_NAME=$(basename $FILE_PATH)

OUTPUT_FILENAME="${2:-$FILE_NAME.decrypted}"

# adding pwd to the path unless it is absolute
if [[ $WORKING_DIR != /* ]]; then
  WORKING_DIR=$(pwd)/$WORKING_DIR
fi

docker run --rm -it -v $WORKING_DIR:/data -w /data -u $(id -u):$(id -g) \
  alpine/openssl:3.3.2 enc -aes-256-cbc -salt -pbkdf2 -a -d \
  -in /data/$FILE_NAME \
  -out /data/$OUTPUT_FILENAME \
  -k ${ENCRYPTION_PASSWORD}

echo "$WORKING_DIR/$OUTPUT_FILENAME"