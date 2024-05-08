-- migrate:up
CREATE TABLE "test_executor"."test_port" (
  "id" SERIAL PRIMARY KEY,
  "execution_id" varchar(50),
  "selenium_port" varchar(50),
  "vnc_port" varchar(50));
  
COMMENT ON COLUMN "test_executor"."test_port"."id" IS 'Id de detención';
COMMENT ON COLUMN "test_executor"."test_port"."execution_id" IS 'id de ejecución';
COMMENT ON COLUMN "test_executor"."test_port"."selenium_port" IS 'puerto liberado para el selenium hub';
COMMENT ON COLUMN "test_executor"."test_port"."vnc_port" IS 'puerto liberado para el nvc server';

-- migrate:down

DROP TABLE IF EXISTS "test_executor"."test_port";