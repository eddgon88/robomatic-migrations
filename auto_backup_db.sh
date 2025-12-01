#!/usr/bin/env bash

# Script para hacer backup automático de la base de datos PostgreSQL
# Este script NO requiere interacción del usuario (usa variables de entorno)
# Uso: ./auto_backup_db.sh [nombre_backup_opcional]

set -e  # Salir si hay algún error

# Colores para output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Directorio donde se guardarán los backups
BACKUP_DIR="${BACKUP_DIR:-$HOME/db_backups}"
mkdir -p "$BACKUP_DIR"

# Nombre del backup (usa parámetro o genera uno con timestamp)
if [ -z "$1" ]; then
    BACKUP_NAME="auto_backup_$(date +%Y%m%d_%H%M%S).sql"
else
    BACKUP_NAME="$1_$(date +%Y%m%d_%H%M%S).sql"
fi

BACKUP_PATH="$BACKUP_DIR/$BACKUP_NAME"

echo -e "${YELLOW}=== Backup Automático de Base de Datos ===${NC}"
echo ""

# Leer configuración desde variables de entorno o usar valores por defecto
DB_HOST="${DB_HOST:-docker-postgresql}"
DB_PORT="${DB_PORT:-5432}"
DB_NAME="${DB_NAME:-core}"
DB_USER="${DB_USER:-robomatic}"
DB_PASS="${DB_PASS:-robomatic}"

# Si no hay contraseña en variable de entorno, intentar leerla del .env de core
if [ -z "$DB_PASS" ] && [ -f "core/.env" ]; then
    echo -e "${YELLOW}Leyendo configuración desde core/.env...${NC}"
    # Extraer la contraseña de la DATABASE_URL
    DB_PASS=$(grep DATABASE_URL core/.env | sed -n 's/.*:\/\/[^:]*:\([^@]*\)@.*/\1/p')
    DB_HOST=$(grep DATABASE_URL core/.env | sed -n 's/.*@\([^:]*\):.*/\1/p')
    DB_PORT=$(grep DATABASE_URL core/.env | sed -n 's/.*:\([0-9]*\)\/.*/\1/p')
    DB_NAME=$(grep DATABASE_URL core/.env | sed -n 's/.*\/\([^?]*\).*/\1/p')
    DB_USER=$(grep DATABASE_URL core/.env | sed -n 's/.*:\/\/\([^:]*\):.*/\1/p')
fi

# Verificar que tenemos las credenciales necesarias
if [ -z "$DB_PASS" ]; then
    echo -e "${RED}Error: No se pudo obtener la contraseña de la base de datos${NC}"
    echo "Define la variable de entorno DB_PASS o asegúrate de que core/.env existe"
    exit 1
fi

echo "Configuración:"
echo "  - Host: $DB_HOST"
echo "  - Puerto: $DB_PORT"
echo "  - Base de datos: $DB_NAME"
echo "  - Usuario: $DB_USER"
echo ""

echo -e "${YELLOW}Creando backup...${NC}"
echo "Ubicación: $BACKUP_PATH"

# Exportar la contraseña para pg_dump
export PGPASSWORD="$DB_PASS"

# Crear archivo temporal para capturar errores
ERROR_LOG=$(mktemp)

# Detectar si estamos en Docker y el host es docker-postgresql
USE_DOCKER_PGDUMP=false
if [ "$DB_HOST" = "docker-postgresql" ]; then
    # Verificar si podemos acceder al contenedor de PostgreSQL
    if command -v docker &> /dev/null; then
        POSTGRES_CONTAINER=$(docker ps --filter "ancestor=postgres:15.5" --format "{{.Names}}" 2>/dev/null | head -1)
        if [ -n "$POSTGRES_CONTAINER" ]; then
            USE_DOCKER_PGDUMP=true
            echo -e "${YELLOW}Usando pg_dump del contenedor PostgreSQL (versión 15.5)...${NC}"
        fi
    fi
fi

# Hacer el backup completo (schema + data)
if [ "$USE_DOCKER_PGDUMP" = true ]; then
    # Ejecutar pg_dump desde dentro del contenedor de PostgreSQL
    if docker exec "$POSTGRES_CONTAINER" pg_dump \
            -U "$DB_USER" \
            -d "$DB_NAME" \
            --format=plain \
            --no-owner \
            --no-acl \
            2>"$ERROR_LOG" > "$BACKUP_PATH"; then
        BACKUP_SUCCESS=true
    else
        BACKUP_SUCCESS=false
    fi
elif pg_dump -h "$DB_HOST" \
        -p "$DB_PORT" \
        -U "$DB_USER" \
        -d "$DB_NAME" \
        --format=plain \
        --no-owner \
        --no-acl \
        -f "$BACKUP_PATH" 2>"$ERROR_LOG"; then
    BACKUP_SUCCESS=true
else
    BACKUP_SUCCESS=false
fi

# Procesar resultado del backup
if [ "$BACKUP_SUCCESS" = true ]; then
    # Limpiar la variable de contraseña
    unset PGPASSWORD
    rm -f "$ERROR_LOG"
    
    # Comprimir el backup
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
    echo ""
    
    # Limpiar backups antiguos (mantener solo los últimos 10)
    echo -e "${YELLOW}Limpiando backups antiguos (manteniendo los últimos 10)...${NC}"
    ls -t "$BACKUP_DIR"/*.sql.gz 2>/dev/null | tail -n +11 | xargs -r rm -f
    
    echo -e "${GREEN}✓ Limpieza completada${NC}"
    echo ""
else
    # Limpiar la variable de contraseña
    unset PGPASSWORD
    
    echo ""
    echo -e "${RED}✗ Error al crear el backup${NC}"
    echo ""
    echo -e "${YELLOW}Detalles del error:${NC}"
    cat "$ERROR_LOG"
    rm -f "$ERROR_LOG"
    echo ""
    echo -e "${YELLOW}Posibles soluciones:${NC}"
    echo "  1. Si estás usando Docker, asegúrate de que el host sea accesible"
    echo "     (prueba con 'localhost' en lugar de 'docker-postgresql')"
    echo "  2. Verifica que PostgreSQL esté corriendo: sudo systemctl status postgresql"
    echo "  3. Verifica las credenciales en core/.env"
    echo "  4. Prueba la conexión manualmente: psql -h $DB_HOST -U $DB_USER -d $DB_NAME"
    echo ""
    echo -e "${YELLOW}Continuando con las migraciones de todas formas...${NC}"
    echo ""
    exit 0  # No fallar, solo advertir
fi
