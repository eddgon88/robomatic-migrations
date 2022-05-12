# migrations

Scripts de migración de base de datos escritas para el DBMS PostgreSQL.

Las DBs disponibles para ser migradas son las siguientes:

| Nombre  | Descripción | Proyectos utilizados |
| ------- | ----------- | ------------------ |
| `cash-api` | Medio de pago efectivo (cupón). | `payments-cash-api`, `payments-gateway-service-status-manager`, `payments-gateway-service-notify-webhooks` |
| `payments` | Ecosistema Pasarela de pagos. | `payments-gateway-api` |
| `pgd-slp` | Web consulta Saldo Lógico Persona (SLP). | `pgd-slp-api` |
| `sonda-api` | Integración compras cuotas de transporte (#RA, carga tarjeta BIP!) pagando con WebPay. | `payments-sonda-api` |
| `tef` | Medio de pago transferencia (TEF) de Pasarela (versión 2), con y sin aviso. | `payments-tef-bot-bco-chile`, `payments-tef-identifier` |
| `tef-mc` | Medio de pago transferencia (TEF) de Core (versión 1), con aviso. | `payments-tef-mc-api`|
| `users` | Módulo de autenticación de usuarios en aplicación `payments-tef-backoffice`. | `payments-users-api` |
| `card_api` | Medio de pago tarjetas (marca blanca). | `payments-card-api` |
| `sodexo_api` | Medio de pago sodexo. | `payments-sodexo-api` |

Además, se incluyen utilidades adicionales para iniciar módulos y ambientes utilizando Docker Compose:

| Comando | Descripción |
| ------- | ----------- |
| `docker-payments` | Levantamiento de ecosistema Pasarela localmente. |
| `docker-postgresql` | Levantamiento de DBMS PostgreSQL |

## 1. Ejecución (Simple)

Establecer la URL y credenciales de acceso a DB dentro de archivo `config_<ENV>`, donde `<ENV>` corresponde al ambiente que se pretende ejecutar:

- `alpha`: ambiente desarrollo.
- `beta`: ambiente QA.
- `docker`: ambiente local creado con contenedores basado en scripts dentro de carpeta `docker-postgresql`. 
- `local`: ambiente local.
- `production`: ambiente productivo, cuyo mantenimiento es realizado por OTI.

Ejecutar comando `run_migrations` para iniciar la migración de todas las BDs.

## Ejecución (Detallada)

### Iniciar docker postgresql

Acceder a la carpeta `./docker-postgresql` e iniciar el docker con postgresql

## Configurar conexión y ejecutar migraciones

### Crear conexión a DBMS

Modificar archivo `config_AMBIENTE` si se requiere y luego ejecutar, ej:

```
sh config_local
```

### [Opción 1] Ejecutar las migraciones de todos los proyectos

```
sh run_migrations
```

### [Opción 2] Ejecutar las migraciones de un proyecto en particular

Acceder a carpeta del sub-proyecto y luego ejecutar:

Linux / osx:

```
dbmate up
```

Windows:

- Convertir finales de lineas a formato Unix con comando `dos2unix **`.
- Ejecutar migraciones con comando `dbmate up` o `./run_migrations`


## Prerequisitos

### PostgreSQL

Crear e iniciar la base de datos mediante docker, acceder a la carpeta `./docker-postgresql` y seguir el [README.md](./docker-postgresql/README.md)

### Dbmate

Las migraciones son realizadas por medio de la herramienta `Dbmate` [(Sitio oficial)](https://github.com/amacneil/dbmate).

#### Instalación de dbmate

`osx`:
```
brew tap amacneil/dbmate

brew install dbmate
```
`linux`:
```
wget -O dbmate https://github.com/amacneil/dbmate/releases/download/v1.6.0/dbmate-linux-amd64

sudo chmod +x dbmate

sudo cp dbmate /usr/local/bin/dbmate
```
`Windows`:

- Descargar `dbmate-windows-amd-64.exe` desde `https://github.com/amacneil/dbmate/releases`
- Renombrar archivo a `dbmate.exe`
- Configurar variables de entorno para incluir en carpeta de aplicación en variable `PATH`

#### Comandos:

  dbmate           # print help
  dbmate new       # generate a new migration file
  dbmate up        # create the database (if it does not already exist) and run any pending migrations
  dbmate create    # create the database
  dbmate drop      # drop the database
  dbmate migrate   # run any pending migrations
  dbmate rollback  # roll back the most recent migration
  dbmate down      # alias for rollback
  dbmate dump      # write the database schema.sql file
  dbmate wait      # wait for the database server to become available

## Estructura migración

Scripts creados para migración se separan de la siguiente forma:

* Esquemas: `dbmate new create_schema_<db-name>`
* Tablas: `dbmate new create_table_<table-name>`
* Indices: `dbmate new create_index_<index-name>`
* Llaves foráneas: `create_foreign_key_<table-fk>`
* Insertar datos: `dbmate new insert_table_<table-name>`

## Extras

Para ejecutar las migraciones en drone se usa una imagen docker con dbmate instalado:

- Fuente: https://github.com/vutreras/dbmate  
- Imagen: https://hub.docker.com/r/vutreras/dbmate
