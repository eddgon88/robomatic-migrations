-- migrate:up

-- Create ai_agent_folder table
CREATE TABLE IF NOT EXISTS core.ai_agent_folder (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    parent_id INTEGER,
    CONSTRAINT fk_ai_agent_folder_parent FOREIGN KEY (parent_id) REFERENCES core.ai_agent_folder(id) ON DELETE CASCADE
);

-- Create ai_agent table
CREATE TABLE IF NOT EXISTS core.ai_agent (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    role TEXT NOT NULL,
    goal TEXT NOT NULL,
    backstory TEXT NOT NULL,
    llm VARCHAR(100) NOT NULL,
    company VARCHAR(100) NOT NULL,
    max_iterations INTEGER DEFAULT 10,
    "verbose" BOOLEAN DEFAULT TRUE,
    temperature DOUBLE PRECISION DEFAULT 0.7,
    folder_id INTEGER,
    CONSTRAINT fk_ai_agent_folder FOREIGN KEY (folder_id) REFERENCES core.ai_agent_folder(id) ON DELETE SET NULL
);


-- Create test_ai_agent join table
CREATE TABLE IF NOT EXISTS core.test_ai_agent (
    test_id INTEGER NOT NULL,
    ai_agent_id INTEGER NOT NULL,
    PRIMARY KEY (test_id, ai_agent_id),
    CONSTRAINT fk_test_ai_agent_test FOREIGN KEY (test_id) REFERENCES core.test(id) ON DELETE CASCADE,
    CONSTRAINT fk_test_ai_agent_agent FOREIGN KEY (ai_agent_id) REFERENCES core.ai_agent(id) ON DELETE CASCADE
);

-- migrate:down

DROP TABLE IF EXISTS core.test_ai_agent;
DROP TABLE IF EXISTS core.ai_agent;
DROP TABLE IF EXISTS core.ai_agent_folder;

