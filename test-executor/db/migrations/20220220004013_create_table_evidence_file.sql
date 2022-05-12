-- migrate:up
CREATE TABLE "test_executor"."evidence_file" (
    "id" bigserial PRIMARY KEY,
    "evidence_id" varchar(100) NOT NULL,
    "file_name" varchar(100) NOT NULL,
    "evidence_uri" varchar(300) NOT NULL,
    "type_id" int4 NOT NULL,
    "test_execution_id" varchar(100) NOT NULL,
    "case_execution_id" varchar(100),
    UNIQUE(evidence_id)
);

COMMENT ON TABLE test_executor.evidence_file IS 'Almacena los datos del archivo de evidencias';
COMMENT ON COLUMN test_executor.evidence_file.id IS 'Clave de registro unico del archivo';
COMMENT ON COLUMN test_executor.evidence_file.evidence_id IS 'Clave de registro unico del archivo';
COMMENT ON COLUMN test_executor.evidence_file.file_name IS 'nombre del archivo';
COMMENT ON COLUMN test_executor.evidence_file.evidence_uri IS 'directorio del archivo';
COMMENT ON COLUMN test_executor.evidence_file.test_execution_id IS 'Clave de registro de la ejecución';

CREATE UNIQUE INDEX evidence_id_idx ON "test_executor"."evidence_file" (evidence_id);
CREATE INDEX file_name ON "test_executor"."evidence_file" (file_name);
CREATE INDEX test_execution_id ON "test_executor"."evidence_file" (test_execution_id);

-- migrate:down
DROP TABLE IF EXISTS "test_executor"."evidence_file";
