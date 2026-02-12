from __future__ import annotations
from dataclasses import dataclass, field
from typing import Any, Dict, Optional
import time
import uuid
import threading


@dataclass
class Job:
    id: str
    status: str  # queued | running | succeeded | failed | cancelled
    created_at: float = field(default_factory=time.time)
    started_at: Optional[float] = None
    finished_at: Optional[float] = None
    input: Optional[Dict[str, Any]] = None
    result: Optional[Dict[str, Any]] = None
    error: Optional[str] = None
    cancel_requested: bool = False


class JobStore:
    def __init__(self):
        self._lock = threading.Lock()
        self._jobs: Dict[str, Job] = {}

    def create(self, payload: Dict[str, Any]) -> Job:
        job_id = str(uuid.uuid4())
        job = Job(id=job_id, status="queued", input=payload)
        with self._lock:
            self._jobs[job_id] = job
        return job

    def get(self, job_id: str) -> Optional[Job]:
        with self._lock:
            return self._jobs.get(job_id)

    def update(self, job_id: str, **kwargs) -> None:
        with self._lock:
            job = self._jobs.get(job_id)
            if not job:
                return
            for k, v in kwargs.items():
                setattr(job, k, v)

    def request_cancel(self, job_id: str) -> bool:
        with self._lock:
            job = self._jobs.get(job_id)
            if not job:
                return False
            job.cancel_requested = True
            # If it hasn't started yet, cancel immediately
            if job.status in ("queued",):
                job.status = "cancelled"
                job.finished_at = time.time()
            return True

    def delete(self, job_id: str) -> bool:
        with self._lock:
            return self._jobs.pop(job_id, None) is not None

    def cleanup(self, ttl_seconds: int) -> int:
        """Delete finished jobs older than TTL. Returns number removed."""
        now = time.time()
        to_delete = []
        with self._lock:
            for job_id, job in self._jobs.items():
                if job.status in ("succeeded", "failed", "cancelled") and job.finished_at:
                    if (now - job.finished_at) > ttl_seconds:
                        to_delete.append(job_id)
            for job_id in to_delete:
                self._jobs.pop(job_id, None)
        return len(to_delete)

    def to_dict(self, job: Job) -> Dict[str, Any]:
        return {
            "job_id": job.id,
            "status": job.status,
            "created_at": job.created_at,
            "started_at": job.started_at,
            "finished_at": job.finished_at,
            "input": job.input,
            "result": job.result,
            "error": job.error,
            "cancel_requested": job.cancel_requested,
        }
