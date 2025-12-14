-- migrate:up
ALTER TABLE "core"."test_credential" 
    ADD CONSTRAINT fk_test_credential_test 
    FOREIGN KEY ("test_id") 
    REFERENCES "core"."test"("id") 
    ON DELETE CASCADE;

ALTER TABLE "core"."test_credential" 
    ADD CONSTRAINT fk_test_credential_type 
    FOREIGN KEY ("credential_type_id") 
    REFERENCES "core"."credential_type"("id");

-- migrate:down
ALTER TABLE "core"."test_credential" DROP CONSTRAINT IF EXISTS fk_test_credential_test;
ALTER TABLE "core"."test_credential" DROP CONSTRAINT IF EXISTS fk_test_credential_type;


