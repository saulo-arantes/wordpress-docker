#!/bin/bash
_os="`uname`"

cat ./wp-data/dump.sql | docker-compose exec -T db sh -c 'exec mysql -uroot -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE"'
