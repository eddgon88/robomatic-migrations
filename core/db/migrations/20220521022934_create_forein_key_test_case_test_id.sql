-- migrate:up
ALTER TABLE "core"."test_case" ADD CONSTRAINT "fk_test_id" FOREIGN KEY ("test_id") REFERENCES "core"."test" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- migrate:down
ALTER TABLE "core"."test_case" DROP CONSTRAINT "fk_test_id";

