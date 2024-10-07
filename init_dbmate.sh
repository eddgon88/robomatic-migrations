#!/bin/sh

# init_dbmate.sh

set -e

# Variables
DOCKERIZE_VERSION=${DOCKERIZE_VERSION:-v0.6.1}

# Descargar y extraer dockerize
wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz
tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz
rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

# Limpieza y ejecución de scripts
sh /db/migrations/config_docker
sh /db/migrations/run_migrations_docker
