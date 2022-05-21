-- migrate:up
ALTER TABLE "core"."test_case" ADD CONSTRAINT "fk_type_id" FOREIGN KEY ("type_id") REFERENCES "core"."test_case_type" ("id") ON UPDATE CASCADE;

-- migrate:down
ALTER TABLE "core"."test_case" DROP CONSTRAINT "fk_type_id";

