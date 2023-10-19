-- migrate:up

ALTER TABLE core.test
ADD COLUMN before_script text,
ADD COLUMN after_script text;

-- migrate:down

ALTER TABLE core.test
DROP COLUMN before_script,
DROP COLUMN after_script;
