# 📋 Resumen de Cambios - Backups Automáticos

## ✅ Archivos Creados

### 1. `auto_backup_db.sh`
Script de backup automático que **NO requiere interacción del usuario**. Lee la configuración desde:
- Variables de entorno (`DB_HOST`, `DB_PORT`, `DB_NAME`, `DB_USER`, `DB_PASS`)
- O desde el archivo `core/.env` automáticamente

**Características:**
- ✅ Backup automático sin preguntas
- ✅ Compresión con gzip
- ✅ Limpieza automática (mantiene solo los últimos 10 backups)
- ✅ No falla si hay error (solo advierte y continúa)

### 2. `backup_db.sh`
Script de backup **interactivo** para uso manual. Te pregunta las credenciales.

### 3. `restore_db.sh`
Script para restaurar backups con confirmación de seguridad.

### 4. `BACKUP_GUIDE.md`
Guía completa de uso de todos los scripts.

---

## 🔄 Archivos Modificados

### 1. `run_migrations`
**Cambios:**
- ✅ Ejecuta `auto_backup_db.sh` automáticamente antes de las migraciones
- ✅ Muestra mensajes con colores (amarillo para pasos, verde para éxito)
- ✅ Continúa con las migraciones incluso si el backup falla (con advertencia)

**Flujo nuevo:**
```
1. PASO 1: Crear backup de seguridad
   └─> Ejecuta auto_backup_db.sh
2. PASO 2: Ejecutar migraciones
   ├─> test-executor
   ├─> core
   └─> n8n
3. ✓ Migraciones completadas exitosamente
```

### 2. `run_migrations_docker`
**Cambios:**
- ✅ Ejecuta `auto_backup_db.sh` automáticamente antes de las migraciones
- ✅ Busca el script en `/db/migrations/auto_backup_db.sh` (ruta Docker)
- ✅ Mismo flujo que `run_migrations` pero adaptado para Docker

---

## 🎯 Cómo Funciona Ahora

### Antes (Manual)
```bash
# Tenías que hacer el backup manualmente
./backup_db.sh pre-migracion
# Luego ejecutar migraciones
./run_migrations
```

### Ahora (Automático)
```bash
# Solo ejecutas las migraciones
./run_migrations

# El script automáticamente:
# 1. Crea un backup en ~/db_backups/
# 2. Ejecuta las migraciones
# 3. Limpia backups antiguos
```

---

## 📂 Ubicación de los Backups

Los backups se guardan en:
```
~/db_backups/
├── pre-migration_20251130_161500.sql.gz
├── pre-migration_20251130_162000.sql.gz
├── pre-migration_20251130_163000.sql.gz
└── ...
```

**Retención:** Se mantienen automáticamente los últimos 10 backups.

---

## 🔧 Configuración

El script `auto_backup_db.sh` lee la configuración de:

1. **Variables de entorno** (prioridad alta):
   ```bash
   export DB_HOST=localhost
   export DB_PORT=5432
   export DB_NAME=core
   export DB_USER=robomatic
   export DB_PASS=tu_password
   ```

2. **Archivo `core/.env`** (automático):
   ```
   DATABASE_URL="postgres://robomatic:password@localhost:5432/core?sslmode=disable"
   ```

---

## 🚨 Manejo de Errores

Si el backup falla:
- ⚠️ Se muestra una advertencia
- ✅ Las migraciones continúan de todas formas
- 📝 Se registra el error en la salida

Si las migraciones fallan:
- ❌ El script se detiene inmediatamente
- 💾 El backup ya está creado
- 🔄 Puedes restaurar con `./restore_db.sh`

---

## 📝 Ejemplo de Salida

```
==========================================
  ROBOMATIC - Ejecución de Migraciones
==========================================

Directorio de proyectos con migraciones: /home/user/robomatic-migrations

PASO 1: Creando backup de seguridad...

=== Backup Automático de Base de Datos ===

Leyendo configuración desde core/.env...
Configuración:
  - Host: docker-postgresql
  - Puerto: 5432
  - Base de datos: core
  - Usuario: robomatic

Creando backup...
Ubicación: /home/user/db_backups/pre-migration_20251130_161500.sql
Comprimiendo backup...

✓ Backup completado exitosamente!

Detalles del backup:
  - Archivo: /home/user/db_backups/pre-migration_20251130_161500.sql.gz
  - Tamaño: 2.3M

Limpiando backups antiguos (manteniendo los últimos 10)...
✓ Limpieza completada

PASO 2: Ejecutando migraciones...

Ejecutando migraciones de test-executor
...
Ejecutando migraciones de core
...
Ejecutando migraciones de n8n
...

==========================================
  ✓ Migraciones completadas exitosamente
==========================================
```

---

## 🎉 Beneficios

1. **Seguridad automática**: Nunca más olvidarás hacer un backup antes de las migraciones
2. **Sin interacción**: No necesitas responder preguntas, todo es automático
3. **Limpieza automática**: No acumulas backups infinitamente
4. **Recuperación rápida**: Si algo falla, tienes el backup listo para restaurar
5. **Trazabilidad**: Cada backup tiene timestamp para saber cuándo se creó

---

## 📞 Próximos Pasos

1. **En tu servidor EC2**, haz pull de los cambios:
   ```bash
   cd /ruta/a/robomatic-migrations
   git pull
   ```

2. **Da permisos de ejecución**:
   ```bash
   chmod +x auto_backup_db.sh backup_db.sh restore_db.sh run_migrations run_migrations_docker
   ```

3. **Ejecuta las migraciones** (ahora con backup automático):
   ```bash
   ./run_migrations
   ```

4. **Si algo sale mal**, restaura:
   ```bash
   ./restore_db.sh ~/db_backups/pre-migration_[timestamp].sql.gz
   ```
