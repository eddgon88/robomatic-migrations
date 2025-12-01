#!/usr/bin/env bash

# Script para restaurar un backup de la base de datos PostgreSQL
# Uso: ./restore_db.sh <ruta_al_backup.sql.gz>

set -e  # Salir si hay algún error

# Colores para output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Verificar que se proporcionó un archivo de backup
if [ -z "$1" ]; then
    echo -e "${RED}Error: Debes proporcionar la ruta al archivo de backup${NC}"
    echo ""
    echo "Uso: ./restore_db.sh <ruta_al_backup.sql.gz>"
    echo ""
    echo "Backups disponibles:"
    ls -lh "$HOME/db_backups" 2>/dev/null | grep -v "^total" | awk '{print "  - " $9 " (" $5 ")"}' || echo "  No hay backups disponibles"
    exit 1
fi

BACKUP_FILE="$1"

# Verificar que el archivo existe
if [ ! -f "$BACKUP_FILE" ]; then
    echo -e "${RED}Error: El archivo $BACKUP_FILE no existe${NC}"
    exit 1
fi

echo -e "${RED}⚠️  ADVERTENCIA: RESTAURACIÓN DE BASE DE DATOS ⚠️${NC}"
echo ""
echo "Esta operación:"
echo "  - Eliminará TODOS los datos actuales de la base de datos"
echo "  - Restaurará los datos desde: $BACKUP_FILE"
echo ""
echo -e "${YELLOW}¿Estás COMPLETAMENTE SEGURO de que quieres continuar?${NC}"
read -p "Escribe 'SI ESTOY SEGURO' para continuar: " CONFIRMATION

if [ "$CONFIRMATION" != "SI ESTOY SEGURO" ]; then
    echo -e "${YELLOW}Operación cancelada${NC}"
    exit 0
fi

echo ""
echo -e "${YELLOW}=== Restauración de Base de Datos PostgreSQL ===${NC}"
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

# Exportar la contraseña para psql
export PGPASSWORD="$DB_PASS"

echo ""
echo -e "${YELLOW}Paso 1: Descomprimiendo backup...${NC}"

# Crear archivo temporal para el SQL descomprimido
TEMP_SQL="/tmp/restore_temp_$(date +%s).sql"

if [[ "$BACKUP_FILE" == *.gz ]]; then
    gunzip -c "$BACKUP_FILE" > "$TEMP_SQL"
else
    cp "$BACKUP_FILE" "$TEMP_SQL"
fi

echo -e "${GREEN}✓ Backup descomprimido${NC}"

echo ""
echo -e "${YELLOW}Paso 2: Terminando conexiones activas a la base de datos...${NC}"

# Terminar todas las conexiones activas a la base de datos
psql -h "$DB_HOST" \
     -p "$DB_PORT" \
     -U "$DB_USER" \
     -d postgres \
     -c "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = '$DB_NAME' AND pid <> pg_backend_pid();" \
     > /dev/null 2>&1 || true

echo -e "${GREEN}✓ Conexiones terminadas${NC}"

echo ""
echo -e "${YELLOW}Paso 3: Eliminando base de datos actual...${NC}"

# Eliminar la base de datos existente
psql -h "$DB_HOST" \
     -p "$DB_PORT" \
     -U "$DB_USER" \
     -d postgres \
     -c "DROP DATABASE IF EXISTS $DB_NAME;" \
     > /dev/null

echo -e "${GREEN}✓ Base de datos eliminada${NC}"

echo ""
echo -e "${YELLOW}Paso 4: Creando nueva base de datos...${NC}"

# Crear una nueva base de datos vacía
psql -h "$DB_HOST" \
     -p "$DB_PORT" \
     -U "$DB_USER" \
     -d postgres \
     -c "CREATE DATABASE $DB_NAME;" \
     > /dev/null

echo -e "${GREEN}✓ Base de datos creada${NC}"

echo ""
echo -e "${YELLOW}Paso 5: Restaurando datos desde backup...${NC}"

# Restaurar el backup
psql -h "$DB_HOST" \
     -p "$DB_PORT" \
     -U "$DB_USER" \
     -d "$DB_NAME" \
     -f "$TEMP_SQL" \
     --quiet

echo -e "${GREEN}✓ Datos restaurados${NC}"

# Limpiar archivo temporal
rm -f "$TEMP_SQL"

# Limpiar la variable de contraseña
unset PGPASSWORD

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}✓ Restauración completada exitosamente!${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo "Detalles:"
echo "  - Base de datos: $DB_NAME"
echo "  - Host: $DB_HOST"
echo "  - Backup restaurado: $BACKUP_FILE"
echo ""
