# 🔧 Solución de Problemas - Backups y Migraciones

## ❌ Error: No se puede conectar a la base de datos

### Síntoma
```
✗ Error al crear el backup
pg_dump: error: connection to server at "docker-postgresql" failed
```

### Causa
El script está intentando conectarse a `docker-postgresql` pero ese hostname solo funciona **dentro** de los contenedores Docker, no desde tu máquina local.

### Solución 1: Usar localhost (Recomendado para desarrollo local)

Crea un archivo `.env` local que sobrescriba la configuración:

```bash
cd /home/edgar/robomatic/proyects/robomatic-migrations/core

# Crear un .env.local con configuración para localhost
cat > .env.local << 'EOF'
DATABASE_URL="postgres://robomatic:robomatic@localhost:5432/core?sslmode=disable"
EOF

# Hacer backup del .env original
cp .env .env.docker

# Usar la configuración local
cp .env.local .env
```

Ahora ejecuta las migraciones:
```bash
cd /home/edgar/robomatic/proyects/robomatic-migrations
./run_migrations
```

### Solución 2: Usar variables de entorno

```bash
export DB_HOST=localhost
export DB_PORT=5432
export DB_NAME=core
export DB_USER=robomatic
export DB_PASS=robomatic

./run_migrations
```

### Solución 3: Ejecutar backup manual con credenciales correctas

```bash
# Usar el script interactivo que te permite especificar el host
./backup_db.sh pre-migracion

# Cuando te pregunte el host, escribe: localhost
# Luego ejecuta las migraciones
./run_migrations
```

### Solución 4: Saltar el backup automático temporalmente

Si solo quieres probar las migraciones sin backup:

```bash
cd core
dbmate up
```

---

## ❌ Error: pg_dump: command not found

### Síntoma
```
pg_dump: command not found
```

### Causa
Las herramientas cliente de PostgreSQL no están instaladas en tu sistema.

### Solución

**Ubuntu/Debian:**
```bash
sudo apt-get update
sudo apt-get install postgresql-client
```

**macOS:**
```bash
brew install postgresql
```

**RHEL/CentOS/Amazon Linux:**
```bash
sudo yum install postgresql
```

---

## ❌ Error: Permission denied al crear directorio de backups

### Síntoma
```
mkdir: cannot create directory '/home/user/db_backups': Permission denied
```

### Solución

```bash
# Crear el directorio manualmente con permisos correctos
mkdir -p ~/db_backups
chmod 755 ~/db_backups

# Intentar de nuevo
./run_migrations
```

---

## ❌ Error: FATAL: password authentication failed

### Síntoma
```
pg_dump: error: connection to server failed: FATAL: password authentication failed for user "robomatic"
```

### Causa
La contraseña en el archivo `.env` es incorrecta.

### Solución

1. Verifica la contraseña correcta:
```bash
# Si estás usando Docker, verifica el docker-compose.yml
cat docker-compose.yml | grep -A 5 postgres

# O verifica las variables de entorno del contenedor
docker exec nombre-contenedor-postgres env | grep POSTGRES_PASSWORD
```

2. Actualiza el archivo `.env`:
```bash
nano core/.env
# Cambia la contraseña en la DATABASE_URL
```

3. O usa variables de entorno:
```bash
export DB_PASS=tu_password_correcta
./run_migrations
```

---

## ❌ Error: database "core" does not exist

### Síntoma
```
pg_dump: error: database "core" does not exist
```

### Solución

La base de datos no existe. Créala primero:

```bash
# Conectarse a PostgreSQL
psql -h localhost -U robomatic -d postgres

# Crear la base de datos
CREATE DATABASE core;

# Salir
\q

# Ahora ejecuta las migraciones
./run_migrations
```

---

## ⚠️ Advertencia: Continuando sin backup

### Síntoma
```
⚠️  Advertencia: No se encontró auto_backup_db.sh
Continuando sin backup...
```

### Causa
El script `auto_backup_db.sh` no está en el directorio o no tiene permisos de ejecución.

### Solución

```bash
cd /home/edgar/robomatic/proyects/robomatic-migrations

# Verificar que el archivo existe
ls -la auto_backup_db.sh

# Si no existe, hacer pull de nuevo
git pull

# Dar permisos de ejecución
chmod +x auto_backup_db.sh backup_db.sh restore_db.sh run_migrations

# Intentar de nuevo
./run_migrations
```

---

## 🐳 Problemas Específicos de Docker

### Ejecutar backup desde dentro del contenedor

Si estás ejecutando todo dentro de Docker:

```bash
# Entrar al contenedor
docker exec -it nombre-contenedor bash

# Dentro del contenedor, las credenciales de .env deberían funcionar
cd /db/migrations
./run_migrations_docker
```

### Mapear el puerto de PostgreSQL

Si quieres hacer backups desde tu máquina local pero PostgreSQL está en Docker:

```yaml
# En tu docker-compose.yml
services:
  postgres:
    ports:
      - "5432:5432"  # Mapear el puerto
```

Luego reinicia el contenedor:
```bash
docker-compose down
docker-compose up -d
```

Ahora puedes usar `localhost:5432` desde tu máquina local.

---

## 🔍 Diagnóstico General

### Verificar conectividad a PostgreSQL

```bash
# Probar conexión con psql
psql -h localhost -U robomatic -d core -c "SELECT version();"

# Si funciona, el problema es con pg_dump
# Si no funciona, el problema es con la configuración de PostgreSQL
```

### Verificar que PostgreSQL está corriendo

```bash
# En sistemas con systemd
sudo systemctl status postgresql

# O si es Docker
docker ps | grep postgres
```

### Verificar logs de PostgreSQL

```bash
# Logs del sistema
sudo tail -f /var/log/postgresql/postgresql-*.log

# Logs de Docker
docker logs nombre-contenedor-postgres
```

### Probar pg_dump manualmente

```bash
# Exportar la contraseña
export PGPASSWORD=robomatic

# Probar pg_dump
pg_dump -h localhost -U robomatic -d core -f test_backup.sql

# Si funciona, el problema es con el script
# Si no funciona, el problema es con pg_dump o PostgreSQL
```

---

## 📋 Checklist de Diagnóstico

Cuando tengas un problema, verifica en orden:

- [ ] PostgreSQL está corriendo (`systemctl status postgresql` o `docker ps`)
- [ ] Puedes conectarte con psql (`psql -h localhost -U robomatic -d core`)
- [ ] El comando `pg_dump` existe (`which pg_dump`)
- [ ] Las credenciales en `core/.env` son correctas
- [ ] El host es accesible (usa `localhost` en lugar de `docker-postgresql` si estás fuera de Docker)
- [ ] El directorio `~/db_backups` existe y tiene permisos de escritura
- [ ] Los scripts tienen permisos de ejecución (`chmod +x *.sh`)

---

## 🆘 Si Nada Funciona

### Opción 1: Hacer backup manual antes de migraciones

```bash
# Backup manual con pg_dump directamente
export PGPASSWORD=robomatic
pg_dump -h localhost -U robomatic -d core -f ~/backup_manual_$(date +%Y%m%d_%H%M%S).sql
gzip ~/backup_manual_*.sql

# Ejecutar migraciones sin backup automático
cd core
dbmate up
```

### Opción 2: Deshabilitar backup automático temporalmente

Edita `run_migrations` y comenta la sección de backup:

```bash
# Comentar estas líneas temporalmente
# if [ -f "$CURRENT_DIR/auto_backup_db.sh" ]; then
#     bash "$CURRENT_DIR/auto_backup_db.sh" "pre-migration"
# fi
```

### Opción 3: Pedir ayuda con información detallada

Recopila esta información:

```bash
# Sistema operativo
uname -a

# Versión de PostgreSQL
psql --version

# Estado de PostgreSQL
systemctl status postgresql || docker ps | grep postgres

# Configuración actual
cat core/.env

# Prueba de conexión
psql -h localhost -U robomatic -d core -c "SELECT 1;"

# Logs del error completo
./run_migrations 2>&1 | tee error.log
```

Comparte el archivo `error.log` para obtener ayuda específica.
