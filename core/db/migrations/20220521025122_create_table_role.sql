-- migrate:up
CREATE TABLE "core"."role" (
    "id" bigserial PRIMARY KEY,
    "name" varchar(300) NOT NULL,
    UNIQUE(name)
);

COMMENT ON TABLE core.role IS 'Almacena los tipos de roles';
COMMENT ON COLUMN core.role.id IS 'Clave de registro unico del tipo de role';
COMMENT ON COLUMN core.role.name IS 'nombre del tipo de role';

CREATE UNIQUE INDEX role_name ON "core"."role" (name);

-- migrate:down
DROP TABLE IF EXISTS "core"."role";
