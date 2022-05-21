-- migrate:up
CREATE TABLE "core"."action" (
    "user_from" int4 NOT NULL,
    "user_to" int4,
    "action_id" int4 NOT NULL,
    "date" timestamp(6) NOT NULL,
    "folder_id" int4,
    "test_id" int4,
    "test_execution_id" int4
);

COMMENT ON TABLE core.action IS 'Almacena las acciones';
COMMENT ON COLUMN core.action.user_from IS 'Usuario que realiza la acción';
COMMENT ON COLUMN core.action.user_to IS 'Usuario que recibe la acción';
COMMENT ON COLUMN core.action.action_id IS 'id de la acción';
COMMENT ON COLUMN core.action.date IS 'fecha de la acción';
COMMENT ON COLUMN core.action.folder_id IS 'id de la carpeta';
COMMENT ON COLUMN core.action.test_id IS 'id del test';
COMMENT ON COLUMN core.action.test_execution_id IS 'id de la ejecución';

CREATE INDEX user_from_action ON "core"."action" (user_from);
CREATE INDEX user_to_action ON "core"."action" (user_to);
CREATE INDEX folder_id_action ON "core"."action" (folder_id);
CREATE INDEX test_id_action ON "core"."action" (test_id);
CREATE INDEX test_execution_id_action ON "core"."action" (test_execution_id);

-- migrate:down
DROP TABLE IF EXISTS "core"."action";
