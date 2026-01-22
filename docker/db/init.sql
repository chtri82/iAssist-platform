CREATE TABLE IF NOT EXISTS results (
    id SERIAL PRIMARY KEY,
    service VARCHAR(50),
    input_data TEXT,
    output_data TEXT,
    created_on TIMESTAMP DEFAULT NOW()
);

INSERT INTO results (service, input_data, output_data)
VALUES ('system', 'init', 'Database initialized successfully');


CREATE TABLE IF NOT EXISTS user_transactions (
    id SERIAL PRIMARY KEY,
    user_id INT,
    amount DECIMAL(10,2),
    category VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO user_transactions (user_id, amount, category)
VALUES (1, 50.25, 'groceries'),
       (2, 100.00, 'utilities'),
       (3, 20.00, 'entertainment');
