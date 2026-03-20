-- migrate:up
ALTER TABLE "core"."ai_agent" ADD COLUMN "user_id" int4;
ALTER TABLE "core"."ai_agent_folder" ADD COLUMN "user_id" int4;

-- Assign existing records to the first admin (usually id 1)
UPDATE "core"."ai_agent" SET "user_id" = 1 WHERE "user_id" IS NULL;
UPDATE "core"."ai_agent_folder" SET "user_id" = 1 WHERE "user_id" IS NULL;

-- Make user_id NOT NULL after assigning defaults
ALTER TABLE "core"."ai_agent" ALTER COLUMN "user_id" SET NOT NULL;
ALTER TABLE "core"."ai_agent_folder" ALTER COLUMN "user_id" SET NOT NULL;

-- Update action table to support AI objects
ALTER TABLE "core"."action" ADD COLUMN "ai_agent_id" int4;
ALTER TABLE "core"."action" ADD COLUMN "ai_agent_folder_id" int4;

-- Add foreign keys
ALTER TABLE "core"."ai_agent" ADD CONSTRAINT "fk_ai_agent_user" FOREIGN KEY ("user_id") REFERENCES "core"."user" ("id");
ALTER TABLE "core"."ai_agent_folder" ADD CONSTRAINT "fk_ai_agent_folder_user" FOREIGN KEY ("user_id") REFERENCES "core"."user" ("id");
ALTER TABLE "core"."action" ADD CONSTRAINT "fk_action_ai_agent" FOREIGN KEY ("ai_agent_id") REFERENCES "core"."ai_agent" ("id");
ALTER TABLE "core"."action" ADD CONSTRAINT "fk_action_ai_agent_folder" FOREIGN KEY ("ai_agent_folder_id") REFERENCES "core"."ai_agent_folder" ("id");

-- migrate:down
ALTER TABLE "core"."action" DROP COLUMN IF EXISTS "ai_agent_folder_id";
ALTER TABLE "core"."action" DROP COLUMN IF EXISTS "ai_agent_id";
ALTER TABLE "core"."ai_agent_folder" DROP COLUMN IF EXISTS "user_id";
ALTER TABLE "core"."ai_agent" DROP COLUMN IF EXISTS "user_id";
