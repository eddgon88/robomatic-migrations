-- migrate:up

CREATE TABLE "core"."token_status" (
    "id" bigserial PRIMARY KEY,
    "name" varchar(300) NOT NULL,
    UNIQUE(name)
);

COMMENT ON TABLE core.token_status IS 'Almacena los tipos de status de token';
COMMENT ON COLUMN core.token_status.id IS 'Clave de registro unico del tipo de status';
COMMENT ON COLUMN core.token_status.name IS 'nombre del tipo de status';

INSERT INTO "core"."token_status" VALUES (1, 'open');
INSERT INTO "core"."token_status" VALUES (2, 'consumed');
INSERT INTO "core"."token_status" VALUES (3, 'expired');
INSERT INTO "core"."token_status" VALUES (4, 'cancelled');

CREATE UNIQUE INDEX token_status_name ON "core"."token_status" (name);

CREATE TABLE "core"."token" (
    "id" bigserial PRIMARY KEY,
    "token" varchar(100) NOT NULL,
    "status" int4 NOT NULL,
    "user_id" int4 NOT NULL,
    "creation_date" timestamp(6) NOT NULL DEFAULT now(),
    "expiration_date" timestamp(6) NOT NULL DEFAULT now()
);

COMMENT ON TABLE core.token IS 'Almacena las acciones';
COMMENT ON COLUMN core.token.token IS 'token de seguridad';
COMMENT ON COLUMN core.token.status IS 'estado del token';
COMMENT ON COLUMN core.token.user_id IS 'id del usuario propietario del token';
COMMENT ON COLUMN core.token.creation_date IS 'fecha de creación del token';
COMMENT ON COLUMN core.token.expiration_date IS 'fecha de expiración del token';

CREATE UNIQUE INDEX token_idx ON "core"."token" (token);
CREATE INDEX token_user_idx ON "core"."token" (user_id);
ALTER TABLE "core"."token" ADD CONSTRAINT "fk_token_status" FOREIGN KEY ("status") REFERENCES "core"."token_status" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- migrate:down
DROP TABLE IF EXISTS "core"."token";
DROP TABLE IF EXISTS "core"."token_status";
