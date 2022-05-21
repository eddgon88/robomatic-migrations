-- migrate:up
ALTER TABLE "core"."folder" ADD CONSTRAINT "fk_folder_idx" FOREIGN KEY ("folder_id") REFERENCES "core"."folder" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- migrate:down
ALTER TABLE "core"."folder" DROP CONSTRAINT "fk_folder_idx";

