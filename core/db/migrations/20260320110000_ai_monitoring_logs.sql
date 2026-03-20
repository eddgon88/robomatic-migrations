-- migrate:up

CREATE TABLE IF NOT EXISTS core.ai_interaction (
    id SERIAL PRIMARY KEY,
    test_execution_id INTEGER NOT NULL,
    agent_name VARCHAR(255) NOT NULL,
    prompt TEXT NOT NULL,
    response TEXT,
    status VARCHAR(50) DEFAULT 'SUCCESS',
    error_message TEXT,
    token_usage INTEGER,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_ai_interaction_execution FOREIGN KEY (test_execution_id) REFERENCES core.test_execution(id) ON DELETE CASCADE
);

-- migrate:down

DROP TABLE IF EXISTS core.ai_interaction;
