-- migrate:up
CREATE TABLE "core"."test_credential" (
    "id" bigserial PRIMARY KEY,
    "credential_id" varchar(100) NOT NULL,
    "test_id" int4 NOT NULL,
    "credential_type_id" int4 NOT NULL,
    "name" varchar(100) NOT NULL,
    "encrypted_value" text,
    "file_path" varchar(500),
    "file_name" varchar(255),
    "created_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(credential_id),
    UNIQUE(test_id, name)
);

COMMENT ON TABLE core.test_credential IS 'Credenciales asociadas a cada test';
COMMENT ON COLUMN core.test_credential.id IS 'Identificador único de la credencial';
COMMENT ON COLUMN core.test_credential.credential_id IS 'ID único de la credencial (formato: cred_xxxxx)';
COMMENT ON COLUMN core.test_credential.test_id IS 'ID del test al que pertenece la credencial';
COMMENT ON COLUMN core.test_credential.credential_type_id IS 'Tipo de credencial (1=PASSWORD, 2=CERTIFICATE)';
COMMENT ON COLUMN core.test_credential.name IS 'Nombre/alias de la credencial para referenciar en scripts';
COMMENT ON COLUMN core.test_credential.encrypted_value IS 'Valor encriptado (para passwords)';
COMMENT ON COLUMN core.test_credential.file_path IS 'Ruta del archivo (para certificados)';
COMMENT ON COLUMN core.test_credential.file_name IS 'Nombre original del archivo subido';
COMMENT ON COLUMN core.test_credential.created_at IS 'Fecha de creación';
COMMENT ON COLUMN core.test_credential.updated_at IS 'Fecha de última actualización';

CREATE UNIQUE INDEX credential_id_idx ON "core"."test_credential" (credential_id);
CREATE INDEX test_credential_test_id_idx ON "core"."test_credential" (test_id);

-- migrate:down
DROP TABLE IF EXISTS "core"."test_credential";


