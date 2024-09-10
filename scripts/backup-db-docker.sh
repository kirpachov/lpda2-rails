#!/bin/bash

SQL_FILE=$(./scripts/export-db-docker.sh)

echo "$SQL_FILE"

ENCRYPTED_SQL_FILE=$(./scripts/encrypt.sh $SQL_FILE)

echo "$ENCRYPTED_SQL_FILE"

echo "Decrypted file: $(./scripts/decrypt.sh $ENCRYPTED_SQL_FILE)"