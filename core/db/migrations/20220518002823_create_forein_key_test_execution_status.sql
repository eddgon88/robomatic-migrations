-- migrate:up
ALTER TABLE "core"."test_execution" ADD CONSTRAINT "fk_test_status" FOREIGN KEY ("status") REFERENCES "core"."test_execution_status" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- migrate:down
ALTER TABLE "core"."test_execution" DROP CONSTRAINT "fk_test_status";

