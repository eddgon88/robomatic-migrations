-- migrate:up
ALTER TABLE "core"."action" ADD CONSTRAINT "fk_user_from_id" FOREIGN KEY ("user_from") REFERENCES "core"."user" ("id") ON UPDATE CASCADE;
ALTER TABLE "core"."action" ADD CONSTRAINT "fk_user_to_id" FOREIGN KEY ("user_to") REFERENCES "core"."user" ("id") ON UPDATE CASCADE;
ALTER TABLE "core"."action" ADD CONSTRAINT "fk_action_id" FOREIGN KEY ("action_id") REFERENCES "core"."action_type" ("id") ON UPDATE CASCADE;
ALTER TABLE "core"."action" ADD CONSTRAINT "fk_folder_id" FOREIGN KEY ("folder_id") REFERENCES "core"."folder" ("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "core"."action" ADD CONSTRAINT "fk_test_id" FOREIGN KEY ("test_id") REFERENCES "core"."test"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "core"."action" ADD CONSTRAINT "fk_test_execution_id" FOREIGN KEY ("test_execution_id") REFERENCES "core"."test_execution" ("id") ON UPDATE CASCADE;

-- migrate:down
ALTER TABLE "core"."user" DROP CONSTRAINT "fk_user_from_id";
ALTER TABLE "core"."user" DROP CONSTRAINT "fk_user_to_id";
ALTER TABLE "core"."user" DROP CONSTRAINT "fk_action_id";
ALTER TABLE "core"."user" DROP CONSTRAINT "fk_folder_id";
ALTER TABLE "core"."user" DROP CONSTRAINT "fk_test_id";
ALTER TABLE "core"."user" DROP CONSTRAINT "fk_test_execution_id";