# 🧪 Guía de Prueba de Migración Segura

## 📋 Descripción

Se ha creado una migración de prueba **completamente segura** que NO afecta ningún dato:

- **Archivo**: `core/db/migrations/20251130162428_test_migration_safe.sql`
- **Acción**: Solo actualiza un comentario en la tabla `core.folder`
- **Impacto**: CERO - No modifica, elimina ni afecta datos

## ✅ Qué Hace Esta Migración

### migrate:up
Actualiza el comentario de la tabla `core.folder` agregando información de prueba:
```sql
COMMENT ON TABLE core.folder IS 'Almacena los datos de las carpetas - [Última actualización: 2025-11-30 - Test de sistema de backups automáticos]';
```

### migrate:down
Revierte el comentario a su estado original:
```sql
COMMENT ON TABLE core.folder IS 'Almacena los datos de las carpetas';
```

## 🧪 Cómo Probar

### Opción 1: Prueba Local (Recomendado primero)

```bash
# 1. Ve al directorio de migraciones
cd /home/edgar/robomatic/proyects/robomatic-migrations

# 2. Ejecuta el script de migraciones (con backup automático)
./run_migrations
```

**Resultado esperado:**
```
==========================================
  ROBOMATIC - Ejecución de Migraciones
==========================================

Directorio de proyectos con migraciones: /home/edgar/robomatic/proyects/robomatic-migrations

PASO 1: Creando backup de seguridad...

=== Backup Automático de Base de Datos ===

Leyendo configuración desde core/.env...
Configuración:
  - Host: docker-postgresql
  - Puerto: 5432
  - Base de datos: core
  - Usuario: robomatic

Creando backup...
✓ Backup completado exitosamente!

Detalles del backup:
  - Archivo: ~/db_backups/pre-migration_20251130_162500.sql.gz
  - Tamaño: X.XM

PASO 2: Ejecutando migraciones...

Ejecutando migraciones de test-executor
Ejecutando migraciones de core
  Applying: 20251130162428_test_migration_safe.sql  ← NUEVA MIGRACIÓN
Ejecutando migraciones de n8n

==========================================
  ✓ Migraciones completadas exitosamente
==========================================
```

### Opción 2: Prueba en EC2 (Producción)

```bash
# 1. Conectarse a EC2
ssh -i tu-llave.pem ec2-user@tu-servidor.com

# 2. Ir al directorio de migraciones
cd /ruta/a/robomatic-migrations

# 3. Hacer pull de los cambios
git pull

# 4. Dar permisos si es necesario
chmod +x run_migrations auto_backup_db.sh

# 5. Ejecutar migraciones (con backup automático)
./run_migrations
```

## 🔍 Verificación

### Verificar que la migración se aplicó

```bash
# Conectarse a PostgreSQL
psql -h localhost -U robomatic -d core

# Ver el comentario actualizado
\d+ core.folder

# Deberías ver algo como:
# Table "core.folder"
# ...
# Comment: Almacena los datos de las carpetas - [Última actualización: 2025-11-30 - Test de sistema de backups automáticos]

# Salir
\q
```

### Verificar que el backup se creó

```bash
# Listar backups
ls -lh ~/db_backups/

# Deberías ver algo como:
# -rw-rw-r-- 1 user user 2.3M Nov 30 16:25 pre-migration_20251130_162500.sql.gz
```

### Verificar que los datos NO se afectaron

```bash
# Conectarse a PostgreSQL
psql -h localhost -U robomatic -d core

# Contar registros en tablas importantes
SELECT COUNT(*) FROM core.folder;
SELECT COUNT(*) FROM core.test;
SELECT COUNT(*) FROM core.user;

# Los números deben ser los mismos que antes
\q
```

## 🔄 Revertir la Migración (Opcional)

Si quieres probar el rollback:

```bash
cd /home/edgar/robomatic/proyects/robomatic-migrations/core
dbmate down
```

Esto ejecutará el `migrate:down` y revertirá el comentario a su estado original.

## 🎯 Qué Estamos Probando

1. ✅ **Backup automático**: Verifica que se crea antes de las migraciones
2. ✅ **Ejecución de migraciones**: Verifica que dbmate funciona correctamente
3. ✅ **Seguridad**: Confirma que los datos no se afectan
4. ✅ **Rollback**: Prueba que podemos revertir cambios
5. ✅ **Limpieza de backups**: Verifica que se mantienen solo los últimos 10

## 📊 Checklist de Prueba

- [ ] Ejecutar `./run_migrations` localmente
- [ ] Verificar que se creó el backup en `~/db_backups/`
- [ ] Verificar que la migración se aplicó (ver comentario en tabla)
- [ ] Verificar que los datos NO cambiaron (contar registros)
- [ ] Verificar que la aplicación sigue funcionando
- [ ] (Opcional) Probar rollback con `dbmate down`
- [ ] (Opcional) Probar en EC2/producción

## 🆘 Si Algo Sale Mal

### Restaurar desde backup

```bash
./restore_db.sh ~/db_backups/pre-migration_YYYYMMDD_HHMMSS.sql.gz
```

### Revertir solo esta migración

```bash
cd core
dbmate down
```

## ✨ Después de la Prueba Exitosa

Si todo funciona bien:

1. ✅ El sistema de backups automáticos está funcionando
2. ✅ Las migraciones se ejecutan correctamente
3. ✅ Estás listo para ejecutar las migraciones reales (password encryption)

### Eliminar la migración de prueba (opcional)

Si quieres limpiar la migración de prueba después:

```bash
# Revertir la migración
cd core
dbmate down

# Eliminar el archivo
rm db/migrations/20251130162428_test_migration_safe.sql

# Regenerar schema.sql
dbmate dump
```

## 📝 Notas Importantes

- Esta migración es **100% segura** - solo modifica metadatos (comentarios)
- No afecta ningún dato de producción
- Es completamente reversible
- Ideal para probar el flujo completo de migraciones + backups

---

## 🎉 ¡Listo!

Ahora puedes probar todo el sistema de migraciones con backups automáticos sin ningún riesgo.
