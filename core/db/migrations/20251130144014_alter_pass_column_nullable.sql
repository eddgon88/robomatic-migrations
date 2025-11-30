-- migrate:up
ALTER TABLE "core"."user" ALTER COLUMN "pass" DROP NOT NULL;

COMMENT ON COLUMN core.user.pass IS 'Contraseña del usuario (legacy - deprecado, usar encrypted_pass)';

-- migrate:down
ALTER TABLE "core"."user" ALTER COLUMN "pass" SET NOT NULL;
