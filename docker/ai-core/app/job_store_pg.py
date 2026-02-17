from typing import Any, Dict, Optional, List

import psycopg2
from psycopg2.extras import Json, RealDictCursor

from app.config.settings import load_services_config, postgres_dsn

class PostgresJobStore:
    def __init__(self):
        cfg = load_services_config()
        self.dsn = postgres_dsn(cfg)

        # psycopg2 DSN string
        self.dsn = (
            f"dbname={pg_cfg['dbname']} "
            f"host={pg_cfg['host']} "
            f"port={pg_cfg['port']} "
            f"user={pg_cfg['user']} "
            f"password={pg_cfg['password']} "
            f"application_name=iassist-ai-core"
        )

    def _conn(self):
        return psycopg2.connect(self.dsn)

    def create(self, job_id: str, payload: Dict[str, Any]) -> None:
        with self._conn() as conn, conn.cursor() as cur:
            cur.execute(
                """
                INSERT INTO ai_jobs (job_id, status, input_json)
                VALUES (%s, %s, %s)
                ON CONFLICT (job_id) DO NOTHING
                """,
                (job_id, "queued", Json(payload)),
            )

    def get(self, job_id: str) -> Optional[Dict[str, Any]]:
        with self._conn() as conn, conn.cursor(cursor_factory=RealDictCursor) as cur:
            cur.execute("SELECT * FROM ai_jobs WHERE job_id=%s", (job_id,))
            row = cur.fetchone()
            return dict(row) if row else None

    def update(self, job_id: str, **fields) -> None:
        if not fields:
            return

        cols = []
        vals = []
        for k, v in fields.items():
            if k in ("input_json", "result_json") and v is not None:
                v = Json(v)
            cols.append(f"{k}=%s")
            vals.append(v)

        vals.append(job_id)
        sql = f"UPDATE ai_jobs SET {', '.join(cols)} WHERE job_id=%s"

        with self._conn() as conn, conn.cursor() as cur:
            cur.execute(sql, vals)

    def request_cancel(self, job_id: str) -> bool:
        with self._conn() as conn, conn.cursor() as cur:
            cur.execute(
                """
                UPDATE ai_jobs
                SET cancel_requested = TRUE
                WHERE job_id=%s
                """,
                (job_id,),
            )
            return cur.rowcount == 1

    def add_event(
        self,
        job_id: str,
        message: str,
        level: str = "info",
        payload: Optional[Dict[str, Any]] = None,
    ) -> None:
        with self._conn() as conn, conn.cursor() as cur:
            cur.execute(
                """
                INSERT INTO ai_job_events (job_id, level, message, payload)
                VALUES (%s, %s, %s, %s)
                """,
                (job_id, level, message, Json(payload) if payload is not None else None),
            )

    def list_recent(self, limit: int = 25) -> List[Dict[str, Any]]:
        with self._conn() as conn, conn.cursor(cursor_factory=RealDictCursor) as cur:
            cur.execute(
                "SELECT * FROM ai_jobs ORDER BY created_at DESC LIMIT %s",
                (limit,),
            )
            return [dict(r) for r in cur.fetchall()]

    def list_events(self, job_id: str, limit: int = 200) -> List[Dict[str, Any]]:
        with self._conn() as conn, conn.cursor(cursor_factory=RealDictCursor) as cur:
            cur.execute(
                """
                SELECT * FROM ai_job_events
                WHERE job_id=%s
                ORDER BY ts ASC
                LIMIT %s
                """,
                (job_id, limit),
            )
            return [dict(r) for r in cur.fetchall()]
    
    def log_tool_invocation(self, tool_name: str, ok: bool, request_id: str | None = None,
            job_id: str | None = None, latency_ms: int | None = None, error_text: str | None = None) -> None:
        with self._conn() as conn, conn.cursor() as cur:
            cur.execute(
                """
                INSERT INTO ai_tool_invocations (request_id, job_id, tool_name, ok, latency_ms, error_text)
                VALUES (%s, %s, %s, %s, %s, %s)
                """,
            (request_id, job_id, tool_name, ok, latency_ms, error_text),
                    )  
            