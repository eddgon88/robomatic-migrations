-- migrate:up
-- Segunda migración de prueba segura - Agrega un índice que mejora el rendimiento
-- Esta migración NO modifica, elimina ni afecta ningún dato existente

-- Crear un índice en la tabla folder para mejorar búsquedas por folder_id
-- Solo se crea si no existe
CREATE INDEX IF NOT EXISTS idx_folder_parent_folder_id ON core.folder(folder_id);

COMMENT ON INDEX core.idx_folder_parent_folder_id IS 'Índice para mejorar búsquedas de carpetas por carpeta padre - Creado en test de migraciones 2025-11-30';

-- migrate:down
-- Revertir eliminando el índice

DROP INDEX IF EXISTS core.idx_folder_parent_folder_id;
