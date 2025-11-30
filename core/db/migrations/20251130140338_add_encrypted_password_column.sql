-- migrate:up
ALTER TABLE "core"."user" ADD COLUMN "encrypted_pass" varchar(60);

COMMENT ON COLUMN core.user.encrypted_pass IS 'Contraseña encriptada del usuario usando BCrypt';

-- migrate:down
ALTER TABLE "core"."user" DROP COLUMN IF EXISTS "encrypted_pass";
