-- migrate:up
INSERT INTO "core"."action_type" VALUES (1, 'create');
INSERT INTO "core"."action_type" VALUES (2, 'update');
INSERT INTO "core"."action_type" VALUES (3, 'delete');
INSERT INTO "core"."action_type" VALUES (4, 'execute');
INSERT INTO "core"."action_type" VALUES (5, 'give execute permissions');
INSERT INTO "core"."action_type" VALUES (6, 'give viewer permissions');
INSERT INTO "core"."action_type" VALUES (7, 'give editor permissions');

-- migrate:down
DELETE FROM "core"."action_type" where id in(1,2,3,4,5,6,7);
