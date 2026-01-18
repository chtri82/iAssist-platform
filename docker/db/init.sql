CREATE TABLE IF NOT EXISTS results (
    id SERIAL PRIMARY KEY,
    service VARCHAR(50),
    input_data TEXT,
    output_data TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO results (service, input_data, output_data)
VALUES ('system', 'init', 'Database initialized successfully');
