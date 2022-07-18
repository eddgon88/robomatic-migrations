-- migrate:up
INSERT INTO "core"."test_execution_status" VALUES (1, 'running');
INSERT INTO "core"."test_execution_status" VALUES (2, 'success');
INSERT INTO "core"."test_execution_status" VALUES (3, 'failed');
INSERT INTO "core"."test_execution_status" VALUES (4, 'stopped');

-- migrate:down
DELETE FROM "core"."test_execution_status" where id in(1,2,3,4);
