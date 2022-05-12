-- migrate:up
INSERT INTO "test_executor"."evidence_type" VALUES (1, 'global');
INSERT INTO "test_executor"."evidence_type" VALUES (2, 'unitary');

-- migrate:down
DELETE FROM "test_executor"."evidence_type" where id in(1,2);