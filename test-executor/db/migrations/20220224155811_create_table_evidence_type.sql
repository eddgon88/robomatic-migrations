-- migrate:up
CREATE TABLE "test_executor"."evidence_type" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar(50));
  
COMMENT ON COLUMN "test_executor"."evidence_type"."id" IS 'Id tipo de evidencia';
COMMENT ON COLUMN "test_executor"."evidence_type"."name" IS 'Nombre tipo de evidencia';

-- migrate:down
DROP TABLE IF EXISTS "test_executor"."evidence_type";