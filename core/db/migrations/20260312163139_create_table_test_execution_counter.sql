-- migrate:up
CREATE TABLE IF NOT EXISTS core.test_execution_counter (
    id SERIAL PRIMARY KEY,
    test_id INT NOT NULL,
    year INT NOT NULL,
    month INT NOT NULL,
    max_executions INT DEFAULT 0,
    current_executions INT DEFAULT 0,
    CONSTRAINT fk_test FOREIGN KEY (test_id) REFERENCES core.test(id),
    CONSTRAINT uk_test_date UNIQUE (test_id, year, month)
);

-- migrate:down
DROP TABLE IF EXISTS core.test_execution_counter;
