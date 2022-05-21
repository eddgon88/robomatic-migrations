-- migrate:up
CREATE TABLE "core"."user" (
    "id" bigserial PRIMARY KEY,
    "full_name" varchar(1000) NOT NULL,
    "role_id" int4 NOT NULL,
    "phone"  varchar(100),
    "email" varchar(1000) NOT NULL,
    UNIQUE(email)
);

COMMENT ON TABLE core.user IS 'Almacena los datos de los usuarios';
COMMENT ON COLUMN core.user.id IS 'Clave de registro unico del usuario';
COMMENT ON COLUMN core.user.full_name IS 'nombre del usuario';
COMMENT ON COLUMN core.user.role_id IS 'rol del usuario';
COMMENT ON COLUMN core.user.phone IS 'numero de telefono del usuario';
COMMENT ON COLUMN core.user.email IS 'email del usuario';

CREATE UNIQUE INDEX email_idx ON "core"."user" (email);

-- migrate:down
DROP TABLE IF EXISTS "core"."user";
