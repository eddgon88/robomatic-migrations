-- migrate:up
CREATE TABLE "test_executor"."stop_execution" (
  "id" SERIAL PRIMARY KEY,
  "execution_id" varchar(50));
  
COMMENT ON COLUMN "test_executor"."stop_execution"."id" IS 'Id de detención';
COMMENT ON COLUMN "test_executor"."stop_execution"."execution_id" IS 'id de ejecución';

-- migrate:down
DROP TABLE IF EXISTS "test_executor"."stop_execution";