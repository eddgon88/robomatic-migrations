-- migrate:up
CREATE TABLE "core"."test" (
    "id" bigserial PRIMARY KEY,
    "test_id" varchar(100) NOT NULL,
    "name" varchar(500) NOT NULL,
    "threads" int4 NOT NULL DEFAULT 1,
    "script" text NOT NULL,
    "web" boolean NOT NULL DEFAULT FALSE,
    "folder_id" int4 NOT NULL,
    "description" text,
    UNIQUE(test_id)
);

COMMENT ON TABLE core.test IS 'Almacena los test con sus configuraciones';
COMMENT ON COLUMN core.test.id IS 'Clave de registro unico del test';
COMMENT ON COLUMN core.test.test_id IS 'Clave de registro unico del test';
COMMENT ON COLUMN core.test.name IS 'nombre del test';
COMMENT ON COLUMN core.test.threads IS 'hilos de ejecución';
COMMENT ON COLUMN core.test.script IS 'script a ejecutar';

CREATE UNIQUE INDEX test_id_idx ON "core"."test" (test_id);
CREATE INDEX folder_id ON "core"."test" (folder_id);

-- migrate:down
DROP TABLE IF EXISTS "core"."test";
