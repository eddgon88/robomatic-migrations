-- migrate:up
ALTER TABLE "test_executor"."evidence_file" ADD CONSTRAINT "evidence_type_fkey" FOREIGN KEY ("type_id") REFERENCES "test_executor"."evidence_type" ("id") ON DELETE NO ACTION ON UPDATE CASCADE;


-- migrate:down
ALTER TABLE "test_executor"."evidence_file" DROP CONSTRAINT "evidence_type_fkey";
