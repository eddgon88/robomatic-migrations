-- migrate:up
CREATE TABLE "core"."test_case" (
    "id" bigserial PRIMARY KEY,
    "test_id" int4 NOT NULL,
    "type_id" int4 NOT NULL,
    "file_dir" varchar(1000) NOT NULL
);

COMMENT ON TABLE core.test_case IS 'Almacena los casos de prueba';
COMMENT ON COLUMN core.test_case.id IS 'Clave de registro unico del caso de prueba';
COMMENT ON COLUMN core.test_case.test_id IS 'id del test al que se le asigna el caso de prueba';
COMMENT ON COLUMN core.test_case.type_id IS 'id del tipo de caso de prueba';
COMMENT ON COLUMN core.test_case.file_dir IS 'dirección del caso de prueba';

-- migrate:down
DROP TABLE IF EXISTS "core"."test_case";
