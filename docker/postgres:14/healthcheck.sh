#!/bin/bash

pg_isready

if [ $? != 0 ]; then
  exit $?;
fi

# su - postgres -c "wal-g backup-list" && echo "$(date) health ok"

