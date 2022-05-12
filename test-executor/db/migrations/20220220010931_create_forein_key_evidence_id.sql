-- migrate:up
ALTER TABLE "test_executor"."case_evidence" ADD CONSTRAINT "fk_evidence_id" FOREIGN KEY ("evidence_id") REFERENCES "test_executor"."evidence_file" ("evidence_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- migrate:down
ALTER TABLE "test_executor"."case_evidence" DROP CONSTRAINT "fk_evidence_id";

