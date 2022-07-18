-- migrate:up
CREATE TABLE "core"."test_execution" (
    "id" bigserial PRIMARY KEY,
    "test_execution_id" varchar(100) NOT NULL,
    "test_id" int4 NOT NULL,
    "test_results_dir" varchar(1000) NOT NULL,
    "status" int4 NOT NULL,    
    UNIQUE(test_execution_id)  
);

COMMENT ON TABLE core.test_execution IS 'Almacena las ejecuciones de los test';
COMMENT ON COLUMN core.test_execution.id IS 'Clave de registro unico de la ejecución';
COMMENT ON COLUMN core.test_execution.test_execution_id IS 'Clave de registro unico de la ejecución';
COMMENT ON COLUMN core.test_execution.test_id IS 'Clave de registro unico del test ejecutado';
COMMENT ON COLUMN core.test_execution.test_results_dir IS 'dirección de los resultados de la ejecución';
COMMENT ON COLUMN core.test_execution.status IS 'estatus de la ejecución';

CREATE UNIQUE INDEX test_execution_id_idx ON "core"."test_execution" (test_execution_id);
CREATE INDEX test_id ON "core"."test_execution" (test_id);

-- migrate:down
DROP TABLE IF EXISTS "core"."test_execution";
