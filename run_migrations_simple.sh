#!/usr/bin/env bash

# Script para ejecutar migraciones desde Docker
# Este script ejecuta las migraciones dentro del contenedor de PostgreSQL

set -e

# Colores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${YELLOW}=========================================="
echo "  Ejecutar Migraciones desde Docker"
echo "==========================================${NC}"
echo ""

# Detectar el nombre del contenedor de PostgreSQL
POSTGRES_CONTAINER=$(docker ps --filter "ancestor=postgres:15.5" --format "{{.Names}}" | head -1)

if [ -z "$POSTGRES_CONTAINER" ]; then
    echo -e "${RED}Error: No se encontró el contenedor de PostgreSQL${NC}"
    echo "Asegúrate de que Docker esté corriendo"
    exit 1
fi

echo -e "${GREEN}✓ Contenedor encontrado: $POSTGRES_CONTAINER${NC}"
echo ""

# Directorio actual
CURRENT_DIR=$(pwd)

echo -e "${YELLOW}PASO 1: Ejecutando migraciones de core...${NC}"
echo ""

# Ejecutar migraciones directamente con docker exec
docker exec -i "$POSTGRES_CONTAINER" psql -U robomatic -d core << 'EOF'
-- Aplicar migración 1: Actualizar comentario
COMMENT ON TABLE core.folder IS 'Almacena los datos de las carpetas - [Última actualización: 2025-11-30 - Test de sistema de backups automáticos]';

-- Aplicar migración 2: Crear índice
CREATE INDEX IF NOT EXISTS idx_folder_parent_folder_id ON core.folder(folder_id);
COMMENT ON INDEX core.idx_folder_parent_folder_id IS 'Índice para mejorar búsquedas de carpetas por carpeta padre - Creado en test de migraciones 2025-11-30';

-- Verificar que se aplicaron
\d+ core.folder
EOF

echo ""
echo -e "${GREEN}=========================================="
echo "  ✓ Migraciones aplicadas exitosamente"
echo "==========================================${NC}"
echo ""
echo "Migraciones aplicadas:"
echo "  1. ✓ Comentario actualizado en tabla folder"
echo "  2. ✓ Índice creado en folder(folder_id)"
echo ""
