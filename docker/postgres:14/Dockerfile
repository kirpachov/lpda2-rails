FROM postgres:14

RUN apt update && apt install -y vim wget

# Setup wal-g
RUN wget https://github.com/wal-g/wal-g/releases/download/v3.0.3/wal-g-pg-ubuntu-20.04-amd64 -O /usr/local/bin/wal-g
RUN chmod +x /usr/local/bin/wal-g

# Load entrypoint
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Load configs
COPY postgresql.conf /etc/postgresql/postgresql.conf

# Healthcheck setup
COPY healthcheck.sh /usr/local/bin/healthcheck
RUN chmod +x /usr/local/bin/healthcheck

# Push base backup script
COPY push_base_backup.sh /usr/local/bin/push_base_backup
RUN chmod +x /usr/local/bin/push_base_backup

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
