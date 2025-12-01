#!/usr/bin/env bash

# Script para hacer backup de la base de datos PostgreSQL
# Uso: ./backup_db.sh [nombre_backup_opcional]

set -e  # Salir si hay algún error

# Colores para output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Directorio donde se guardarán los backups
BACKUP_DIR="$HOME/db_backups"
mkdir -p "$BACKUP_DIR"

# Nombre del backup (usa parámetro o genera uno con timestamp)
if [ -z "$1" ]; then
    BACKUP_NAME="backup_$(date +%Y%m%d_%H%M%S).sql"
else
    BACKUP_NAME="$1_$(date +%Y%m%d_%H%M%S).sql"
fi

BACKUP_PATH="$BACKUP_DIR/$BACKUP_NAME"

echo -e "${YELLOW}=== Backup de Base de Datos PostgreSQL ===${NC}"
echo ""

# Solicitar credenciales de la base de datos
read -p "Host de la base de datos [localhost]: " DB_HOST
DB_HOST=${DB_HOST:-localhost}

read -p "Puerto [5432]: " DB_PORT
DB_PORT=${DB_PORT:-5432}

read -p "Nombre de la base de datos [core]: " DB_NAME
DB_NAME=${DB_NAME:-core}

read -p "Usuario de PostgreSQL [robomatic]: " DB_USER
DB_USER=${DB_USER:-robomatic}

read -sp "Contraseña: " DB_PASS
echo ""

echo ""
echo -e "${YELLOW}Creando backup...${NC}"
echo "Ubicación: $BACKUP_PATH"

# Exportar la contraseña para pg_dump
export PGPASSWORD="$DB_PASS"

# Hacer el backup completo (schema + data)
pg_dump -h "$DB_HOST" \
        -p "$DB_PORT" \
        -U "$DB_USER" \
        -d "$DB_NAME" \
        --verbose \
        --format=plain \
        --no-owner \
        --no-acl \
        -f "$BACKUP_PATH"

# Limpiar la variable de contraseña
unset PGPASSWORD

# Comprimir el backup
echo ""
echo -e "${YELLOW}Comprimiendo backup...${NC}"
gzip "$BACKUP_PATH"
BACKUP_PATH="${BACKUP_PATH}.gz"

# Calcular tamaño del backup
BACKUP_SIZE=$(du -h "$BACKUP_PATH" | cut -f1)

echo ""
echo -e "${GREEN}✓ Backup completado exitosamente!${NC}"
echo ""
echo "Detalles del backup:"
echo "  - Archivo: $BACKUP_PATH"
echo "  - Tamaño: $BACKUP_SIZE"
echo "  - Base de datos: $DB_NAME"
echo "  - Host: $DB_HOST"
echo ""
echo -e "${YELLOW}Para restaurar este backup, usa:${NC}"
echo "  ./restore_db.sh $BACKUP_PATH"
echo ""

# Listar backups existentes
echo -e "${YELLOW}Backups disponibles en $BACKUP_DIR:${NC}"
ls -lh "$BACKUP_DIR" | grep -v "^total" | awk '{print "  - " $9 " (" $5 ")"}'
echo ""
