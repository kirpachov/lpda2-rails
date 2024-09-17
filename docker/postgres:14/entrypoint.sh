#!/bin/bash

# Do your stuff here ...
echo "{ \"AWS_ACCESS_KEY_ID\": \"${AWS_ACCESS_KEY_ID?error}\", \"AWS_REGION\": \"${AWS_REGION?error}\", \"AWS_SECRET_ACCESS_KEY\": \"${AWS_SECRET_ACCESS_KEY?error}\", \"WALG_S3_PREFIX\": \"${WALG_S3_PREFIX?required}\" }" > /var/lib/postgresql/.walg.json
chown postgres:postgres /var/lib/postgresql/.walg.json

# Then call postgre's docker entrypoint
# V1:
# source /usr/local/bin/docker-entrypoint.sh

# if [ "$#" -eq 0 ] || [ "$@" = '' ]; then
#   set -- postgres "$@"
# fi

# _main "$@"

# V2:
/usr/local/bin/docker-ensure-initdb.sh

cp /etc/postgresql/postgresql.conf /var/lib/postgresql/data/postgresql.conf

source /usr/local/bin/docker-entrypoint.sh

if [ "$#" -eq 0 ] || [ "$@" = '' ]; then
  set -- postgres "$@"
fi

_main "$@"