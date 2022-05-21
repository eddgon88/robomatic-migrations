-- migrate:up
INSERT INTO "core"."test_case_type" VALUES (1, 'default');
INSERT INTO "core"."test_case_type" VALUES (2, 'scheduled');
INSERT INTO "core"."test_case_type" VALUES (3, 'sequential');

-- migrate:down
DELETE FROM "core"."test_case_type" where id in(1,2,3);
