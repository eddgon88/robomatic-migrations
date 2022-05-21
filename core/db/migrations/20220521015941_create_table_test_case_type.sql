-- migrate:up
CREATE TABLE "core"."test_case_type" (
    "id" bigserial PRIMARY KEY,
    "name" varchar(1000) NOT NULL,
    UNIQUE(name)
);

COMMENT ON TABLE core.test_case_type IS 'Almacena los tipos de casos de prueba';
COMMENT ON COLUMN core.test_case_type.id IS 'Clave de registro unico del tipo de caso de prueba';
COMMENT ON COLUMN core.test_case_type.name IS 'nombre del tipo de caso de prueba';

CREATE UNIQUE INDEX test_case_type_name ON "core"."test_case_type" (name);

-- migrate:down
DROP TABLE IF EXISTS "core"."test_case_type";
