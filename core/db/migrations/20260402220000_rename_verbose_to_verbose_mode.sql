-- migrate:up
ALTER TABLE core.ai_agent RENAME COLUMN "verbose" TO verbose_mode;

-- migrate:down
ALTER TABLE core.ai_agent RENAME COLUMN verbose_mode TO "verbose";
