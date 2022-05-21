-- migrate:up
ALTER TABLE "core"."test" ADD CONSTRAINT "fk_folder_id" FOREIGN KEY ("folder_id") REFERENCES "core"."folder" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- migrate:down
ALTER TABLE "core"."test" DROP CONSTRAINT "fk_folder_id";

