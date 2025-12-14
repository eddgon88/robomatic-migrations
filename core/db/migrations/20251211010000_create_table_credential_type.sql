-- migrate:up
CREATE TABLE "core"."credential_type" (
    "id" serial PRIMARY KEY,
    "name" varchar(50) NOT NULL,
    "description" varchar(255)
);

COMMENT ON TABLE core.credential_type IS 'Tipos de credenciales disponibles (PASSWORD, CERTIFICATE)';
COMMENT ON COLUMN core.credential_type.id IS 'Identificador único del tipo de credencial';
COMMENT ON COLUMN core.credential_type.name IS 'Nombre del tipo (PASSWORD, CERTIFICATE)';
COMMENT ON COLUMN core.credential_type.description IS 'Descripción del tipo de credencial';

-- migrate:down
DROP TABLE IF EXISTS "core"."credential_type";


