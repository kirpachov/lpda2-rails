#!/bin/bash

# Run it from the root of the project with
# ENCRYPTION_PASSWORD=Mario LPDA2_DATABASE_PASSWORD="somethingNooneWillGuess" DATABASE_NAME=lpda2_development ./scripts/export-db-docker.sh

output_filename="backup-$(date +"%Y_%m_%d_%H:%M").sql"

LPDA2_DATABASE_PASSWORD="${LPDA2_DATABASE_PASSWORD:-somethingNooneWillGuess}"
DATABASE_NAME="${DATABASE_NAME:-lpda2_development}"
HOST_WORKSPACE="${HOST_WORKSPACE:-/home/$(whoami)/lpda2-backups}"
# ENCRYPTION_PASSWORD="${ENCRYPTION_PASSWORD?Please provide ENCRYPTION_PASSWORD to encrypt the backup}"

mkdir -p $HOST_WORKSPACE

# If network is not found, check how is called with `docker network ls`.

docker run --network rails-lpda2_default \
           --volume $HOST_WORKSPACE:/data/ \
           -w /data \
           postgres:14-alpine bash -c \
           "PGPASSWORD=\"$LPDA2_DATABASE_PASSWORD\" pg_dump -h postgres $DATABASE_NAME \
                                                            -f /data/$output_filename"

if [ $? != 0 ]; then
  echo "Backup failed"
  exit $?
fi

echo "$HOST_WORKSPACE/$output_filename"
