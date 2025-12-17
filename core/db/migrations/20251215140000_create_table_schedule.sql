-- migrate:up
CREATE TABLE IF NOT EXISTS core.schedule (
    id SERIAL PRIMARY KEY,
    schedule_id VARCHAR(100) NOT NULL UNIQUE,
    test_id INTEGER NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    trigger_type VARCHAR(20) NOT NULL,
    expression JSONB NOT NULL,
    status INTEGER NOT NULL DEFAULT 1,
    next_run_time TIMESTAMP,
    last_run_time TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_schedule_test FOREIGN KEY (test_id) REFERENCES core.test(id) ON DELETE CASCADE
);

CREATE INDEX idx_schedule_test_id ON core.schedule(test_id);
CREATE INDEX idx_schedule_status ON core.schedule(status);

COMMENT ON TABLE core.schedule IS 'Stores scheduled test executions configuration';
COMMENT ON COLUMN core.schedule.schedule_id IS 'Unique identifier for the scheduler API';
COMMENT ON COLUMN core.schedule.trigger_type IS 'Type: cron, interval, or date';
COMMENT ON COLUMN core.schedule.expression IS 'JSON with trigger configuration';
COMMENT ON COLUMN core.schedule.status IS '1=Active, 2=Paused, 3=Deleted';

-- migrate:down
DROP TABLE IF EXISTS core.schedule;


