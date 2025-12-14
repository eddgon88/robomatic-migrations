-- migrate:up
INSERT INTO "core"."credential_type" ("id", "name", "description") VALUES 
    (1, 'PASSWORD', 'Contraseña encriptada para autenticación'),
    (2, 'CERTIFICATE', 'Archivo de certificado (SSL, API keys, etc.)');

-- migrate:down
DELETE FROM "core"."credential_type" WHERE "id" IN (1, 2);


