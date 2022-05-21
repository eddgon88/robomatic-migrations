-- migrate:up
INSERT INTO "core"."user" VALUES (1, 'admin', 1, null, 'edgarantonio0813@gmail.com');

-- migrate:down
DELETE FROM "core"."user" where id in(1);
