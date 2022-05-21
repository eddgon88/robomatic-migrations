-- migrate:up
CREATE TABLE "core"."case_execution" (
    "id" bigserial PRIMARY KEY,
    "case_execution_id" varchar(100) NOT NULL,
    "test_execution_id" varchar(100) NOT NULL,
    "case_results_dir" varchar(1000) NOT NULL,
    "status" varchar(50) NOT NULL,    
    UNIQUE(case_execution_id)  
);

COMMENT ON TABLE core.case_execution IS 'Almacena los casos de las ejecuciones';
COMMENT ON COLUMN core.case_execution.id IS 'Clave de registro unico del caso';
COMMENT ON COLUMN core.case_execution.case_execution_id IS 'Clave de registro unico del caso';
COMMENT ON COLUMN core.case_execution.test_execution_id IS 'Clave de registro unico de la ejecución';
COMMENT ON COLUMN core.case_execution.case_results_dir IS 'dirección de los resultados del caso';
COMMENT ON COLUMN core.case_execution.status IS 'estatus del caso';

CREATE UNIQUE INDEX case_execution_id_idx ON "core"."case_execution" (case_execution_id);
CREATE INDEX test_execution_id ON "core"."case_execution" (test_execution_id);

-- migrate:down
DROP TABLE IF EXISTS "core"."case_execution";
