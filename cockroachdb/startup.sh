#!/usr/bin/env sh

cockroach start-single-node --insecure --listen-addr=0.0.0.0 --http-addr 0.0.0.0:18080 --background --max-sql-memory=.25
cockroach sql --accept-sql-without-tls  < /opt/cockroachdb/local-init.sql
tail -f /dev/null
