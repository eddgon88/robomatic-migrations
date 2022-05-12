-- migrate:up
CREATE TABLE "test_executor"."case_evidence" (
    "id" bigserial PRIMARY KEY,
    "evidence_id" varchar(100) NOT NULL,
    "evidence_text" text,
    "creation_date" timestamp(6)
);

COMMENT ON TABLE test_executor.case_evidence IS 'Almacena los datos de los registros de evidencias';
COMMENT ON COLUMN test_executor.case_evidence.id IS 'Clave de registro unico del registro';
COMMENT ON COLUMN test_executor.case_evidence.evidence_id IS 'Clave de registro unico del archivo';
COMMENT ON COLUMN test_executor.case_evidence.evidence_text IS 'texto del registro';

CREATE INDEX evidence_id ON "test_executor"."case_evidence" (evidence_id);

-- migrate:down
DROP TABLE IF EXISTS "test_executor"."case_evidence";
