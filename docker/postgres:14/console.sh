#!/bin/bash

# Will start bash after starting the postgres server

su - postgres -c "/usr/lib/postgresql/14/bin/postgres -D /var/lib/postgresql/data/" &

bash
