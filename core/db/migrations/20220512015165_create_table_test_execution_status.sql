-- migrate:up
CREATE TABLE "core"."test_execution_status" (
    "id" bigserial PRIMARY KEY,
    "name" varchar(300) NOT NULL,
    UNIQUE(name)
);

COMMENT ON TABLE core.test_execution_status IS 'Almacena los tipos de status de ejecución';
COMMENT ON COLUMN core.test_execution_status.id IS 'Clave de registro unico del tipo de status';
COMMENT ON COLUMN core.test_execution_status.name IS 'nombre del tipo de status';

CREATE UNIQUE INDEX test_execution_status_name ON "core"."test_execution_status" (name);

-- migrate:down
DROP TABLE IF EXISTS "core"."test_execution_status";
