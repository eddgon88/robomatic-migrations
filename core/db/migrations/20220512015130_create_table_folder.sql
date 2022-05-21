-- migrate:up
CREATE TABLE "core"."folder" (
    "id" bigserial PRIMARY KEY,
    "name" varchar(1000) NOT NULL,
    "folder_id" int4
);

COMMENT ON TABLE core.folder IS 'Almacena los datos de las carpetas';
COMMENT ON COLUMN core.folder.id IS 'Clave de registro unico de la carpeta';
COMMENT ON COLUMN core.folder.name IS 'nombre de la carpeta';

-- migrate:down
DROP TABLE IF EXISTS "core"."folder";
