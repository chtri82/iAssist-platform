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

-- ============================
-- iAssist AI Core Jobs (public)
-- ============================

CREATE TABLE IF NOT EXISTS ai_jobs (
  job_id           UUID PRIMARY KEY,
  status           TEXT NOT NULL,
  created_at       TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  started_at       TIMESTAMPTZ NULL,
  finished_at      TIMESTAMPTZ NULL,
  input_json       JSONB NULL,
  result_json      JSONB NULL,
  error_text       TEXT NULL,
  cancel_requested BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE INDEX IF NOT EXISTS idx_ai_jobs_created_at ON ai_jobs(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_ai_jobs_status ON ai_jobs(status);

CREATE TABLE IF NOT EXISTS ai_job_events (
  id         BIGSERIAL PRIMARY KEY,
  job_id     UUID NOT NULL REFERENCES ai_jobs(job_id) ON DELETE CASCADE,
  ts         TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  level      TEXT NOT NULL DEFAULT 'info',
  message    TEXT NOT NULL,
  payload    JSONB NULL
);

CREATE INDEX IF NOT EXISTS idx_ai_job_events_job_id_ts ON ai_job_events(job_id, ts);

CREATE TABLE IF NOT EXISTS ai_tool_invocations (
  id            BIGSERIAL PRIMARY KEY,
  ts            TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  request_id    TEXT NULL,
  job_id        UUID NULL,
  tool_name     TEXT NOT NULL,
  ok            BOOLEAN NOT NULL,
  latency_ms    INTEGER NULL,
  error_text    TEXT NULL
);

CREATE INDEX IF NOT EXISTS idx_ai_tool_invocations_ts ON ai_tool_invocations(ts DESC);
CREATE INDEX IF NOT EXISTS idx_ai_tool_invocations_tool ON ai_tool_invocations(tool_name, ts DESC);
CREATE INDEX IF NOT EXISTS idx_ai_tool_invocations_job ON ai_tool_invocations(job_id, ts DESC);