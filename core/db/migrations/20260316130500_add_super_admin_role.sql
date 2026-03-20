-- migrate:up
INSERT INTO core.role (id, name) VALUES (5, 'Super Admin') ON CONFLICT (id) DO NOTHING;

-- Grant global access to Super Admin (only one per instance)
CREATE UNIQUE INDEX uk_super_admin ON core."user" (role_id) WHERE role_id = 5;

-- migrate:down
DROP INDEX IF EXISTS core.uk_super_admin;
DELETE FROM core.role WHERE id = 5;
