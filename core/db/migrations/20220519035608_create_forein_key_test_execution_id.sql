-- migrate:up
ALTER TABLE "core"."case_execution" ADD CONSTRAINT "fk_test_execution_id" FOREIGN KEY ("test_execution_id") REFERENCES "core"."test_execution" ("test_execution_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- migrate:down
ALTER TABLE "core"."case_execution" DROP CONSTRAINT "fk_test_execution_id";

