# 📚 Guía de Backup y Restauración de Base de Datos

Esta guía te ayudará a crear backups de tu base de datos PostgreSQL en producción y restaurarlos en caso de emergencia.

## 🚀 Inicio Rápido

### ✨ Backups Automáticos (Nuevo)

Los scripts `run_migrations` y `run_migrations_docker` ahora **crean backups automáticamente** antes de ejecutar las migraciones. Solo necesitas:

```bash
# En tu servidor EC2 de producción
cd /ruta/a/robomatic-migrations
./run_migrations
```

El script automáticamente:
1. ✅ Creará un backup en `~/db_backups/`
2. ✅ Ejecutará las migraciones
3. ✅ Limpiará backups antiguos (mantiene los últimos 10)

### 1. Hacer un Backup Manual (Opcional)

Si quieres hacer un backup manual en cualquier momento:

```bash
# Backup interactivo (te pedirá credenciales)
./backup_db.sh nombre-descriptivo

# Backup automático (usa configuración de core/.env)
./auto_backup_db.sh nombre-descriptivo
```

### 2. Restaurar un Backup (si algo sale mal)

```bash
# En tu servidor EC2 de producción
chmod +x restore_db.sh
./restore_db.sh ~/db_backups/pre-migration_YYYYMMDD_HHMMSS.sql.gz
```

---

## 📖 Guía Detallada

### Preparación Inicial

1. **Conectarte a tu EC2:**
   ```bash
   ssh -i tu-llave.pem ec2-user@tu-servidor.com
   ```

2. **Navegar al directorio de migraciones:**
   ```bash
   cd /ruta/donde/esta/robomatic-migrations
   ```

3. **Dar permisos de ejecución a los scripts:**
   ```bash
   chmod +x backup_db.sh restore_db.sh
   ```

### Crear un Backup

#### Opción 1: Backup con nombre personalizado
```bash
./backup_db.sh nombre-descriptivo
# Ejemplo: ./backup_db.sh pre-migracion-password
```

#### Opción 2: Backup con timestamp automático
```bash
./backup_db.sh
```

**El script te pedirá:**
- Host de la base de datos (presiona Enter para usar `localhost`)
- Puerto (presiona Enter para usar `5432`)
- Nombre de la base de datos (presiona Enter para usar `core`)
- Usuario (presiona Enter para usar `robomatic`)
- Contraseña

**Resultado:**
- El backup se guardará en `~/db_backups/`
- Se comprimirá automáticamente con gzip
- Verás el tamaño del archivo y la ubicación

### Restaurar un Backup

> ⚠️ **ADVERTENCIA:** La restauración eliminará TODOS los datos actuales

```bash
./restore_db.sh ~/db_backups/backup_20251130_161500.sql.gz
```

**El script:**
1. Te pedirá confirmación (debes escribir exactamente: `SI ESTOY SEGURO`)
2. Solicitará las credenciales de la base de datos
3. Terminará todas las conexiones activas
4. Eliminará la base de datos actual
5. Creará una nueva base de datos
6. Restaurará todos los datos desde el backup

---

## 🛡️ Mejores Prácticas

### Antes de Ejecutar Migraciones en Producción

1. **Hacer backup:**
   ```bash
   ./backup_db.sh pre-migracion-$(date +%Y%m%d)
   ```

2. **Verificar que el backup se creó correctamente:**
   ```bash
   ls -lh ~/db_backups/
   ```

3. **Ejecutar las migraciones:**
   ```bash
   ./run_migrations
   ```

4. **Verificar que todo funciona correctamente**

5. **Si algo sale mal, restaurar:**
   ```bash
   ./restore_db.sh ~/db_backups/pre-migracion-YYYYMMDD_HHMMSS.sql.gz
   ```

### Programar Backups Automáticos (Opcional)

Puedes crear un cron job para backups automáticos diarios:

```bash
# Editar crontab
crontab -e

# Agregar esta línea para backup diario a las 2 AM
0 2 * * * /ruta/a/robomatic-migrations/backup_db.sh auto-backup
```

### Limpiar Backups Antiguos

```bash
# Ver backups existentes
ls -lh ~/db_backups/

# Eliminar backups más antiguos de 30 días
find ~/db_backups/ -name "*.sql.gz" -mtime +30 -delete
```

---

## 🔧 Comandos Manuales (Alternativa)

Si prefieres hacer el backup manualmente sin los scripts:

### Backup Manual
```bash
# Backup completo
pg_dump -h localhost -U robomatic -d core -F p -f backup.sql

# Comprimir
gzip backup.sql
```

### Restauración Manual
```bash
# Descomprimir
gunzip backup.sql.gz

# Restaurar
psql -h localhost -U robomatic -d core -f backup.sql
```

---

## 📊 Verificar el Estado de la Base de Datos

### Antes del Backup
```bash
# Conectarse a PostgreSQL
psql -h localhost -U robomatic -d core

# Ver tablas
\dt core.*

# Ver cantidad de registros en tabla user
SELECT COUNT(*) FROM core.user;

# Salir
\q
```

### Después de la Restauración
Ejecutar los mismos comandos para verificar que los datos se restauraron correctamente.

---

## ❓ Preguntas Frecuentes

### ¿Cuánto espacio ocupan los backups?
Depende del tamaño de tu base de datos. Los backups se comprimen con gzip, típicamente reduciendo el tamaño en un 70-90%.

### ¿Puedo hacer backup mientras la aplicación está corriendo?
Sí, `pg_dump` hace un snapshot consistente sin bloquear la base de datos.

### ¿Cuánto tiempo toma hacer un backup?
Depende del tamaño de la base de datos. Para bases de datos pequeñas (<1GB), usualmente toma menos de 1 minuto.

### ¿Puedo restaurar un backup en un servidor diferente?
Sí, solo asegúrate de que la versión de PostgreSQL sea compatible.

### ¿Qué pasa si el backup falla?
El script mostrará un error. Verifica:
- Que PostgreSQL esté corriendo
- Que las credenciales sean correctas
- Que haya espacio en disco suficiente

---

## 🆘 En Caso de Emergencia

Si algo sale mal después de ejecutar las migraciones:

1. **No entres en pánico** 🧘
2. **No hagas más cambios** ⛔
3. **Restaura el backup inmediatamente:**
   ```bash
   ./restore_db.sh ~/db_backups/[tu-backup-mas-reciente].sql.gz
   ```
4. **Verifica que la aplicación funciona correctamente**
5. **Investiga qué salió mal antes de intentar de nuevo**

---

## 📞 Contacto y Soporte

Si tienes problemas:
- Revisa los logs de PostgreSQL: `/var/log/postgresql/`
- Verifica el estado del servicio: `sudo systemctl status postgresql`
- Revisa el espacio en disco: `df -h`
