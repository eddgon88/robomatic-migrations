-- migrate:up
CREATE TABLE "core"."action_type" (
    "id" bigserial PRIMARY KEY,
    "name" varchar(300) NOT NULL,
    UNIQUE(name)
);

COMMENT ON TABLE core.action_type IS 'Almacena los tipos de acciones';
COMMENT ON COLUMN core.action_type.id IS 'Clave de registro unico del tipo de acción';
COMMENT ON COLUMN core.action_type.name IS 'nombre del tipo de acción';

CREATE UNIQUE INDEX action_type_name ON "core"."action_type" (name);

-- migrate:down
DROP TABLE IF EXISTS "core"."action_type";
