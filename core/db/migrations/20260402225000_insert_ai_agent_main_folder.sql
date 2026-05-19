-- migrate:up

-- Insert the root folder for AI agents (id=0) similar to the test folder system
-- We need to manually set the id to 0 since SERIAL starts at 1
INSERT INTO core.ai_agent_folder (id, name, parent_id, user_id) VALUES (0, 'main', NULL, 1);

-- Fix any existing agents without a folder_id (assign them to root)
UPDATE core.ai_agent SET folder_id = 0 WHERE folder_id IS NULL;

-- Make folder_id NOT NULL with default 0
ALTER TABLE core.ai_agent ALTER COLUMN folder_id SET DEFAULT 0;
ALTER TABLE core.ai_agent ALTER COLUMN folder_id SET NOT NULL;

-- migrate:down
ALTER TABLE core.ai_agent ALTER COLUMN folder_id DROP NOT NULL;
ALTER TABLE core.ai_agent ALTER COLUMN folder_id DROP DEFAULT;
DELETE FROM core.ai_agent_folder WHERE id = 0;
