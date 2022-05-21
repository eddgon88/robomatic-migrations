-- migrate:up
ALTER TABLE "core"."user" ADD CONSTRAINT "fk_role_id" FOREIGN KEY ("role_id") REFERENCES "core"."role" ("id") ON UPDATE CASCADE;

-- migrate:down
ALTER TABLE "core"."user" DROP CONSTRAINT "fk_role_id";

