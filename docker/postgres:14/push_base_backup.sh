su - postgres -c "/usr/lib/postgresql/14/bin/postgres -D /var/lib/postgresql/data/" &

sleep 5

PGHOST=/var/run/postgresql/ wal-g backup-push