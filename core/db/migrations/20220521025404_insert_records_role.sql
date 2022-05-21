-- migrate:up
INSERT INTO "core"."role" VALUES (1, 'admin');
INSERT INTO "core"."role" VALUES (2, 'executor');
INSERT INTO "core"."role" VALUES (3, 'viewer');
INSERT INTO "core"."role" VALUES (4, 'analist');

-- migrate:down
DELETE FROM "core"."role" where id in(1,2,3,4);
