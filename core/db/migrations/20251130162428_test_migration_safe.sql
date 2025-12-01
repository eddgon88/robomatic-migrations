-- migrate:up
-- Migración de prueba segura - Solo agrega un comentario a una tabla existente
-- Esta migración NO modifica, elimina ni afecta ningún dato existente

COMMENT ON TABLE core.folder IS 'Almacena los datos de las carpetas - [Última actualización: 2025-11-30 - Test de sistema de backups automáticos]';

-- migrate:down
-- Revertir el comentario a su estado original

COMMENT ON TABLE core.folder IS 'Almacena los datos de las carpetas';
