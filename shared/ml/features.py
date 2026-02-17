from dataclasses import dataclass
from datetime import datetime, timezone
from typing import Dict, Any

@dataclass
class FeatureRow:
    amount: float
    hour: int
    day_of_week: int
    month: int

def build_features(amount: float, ts: datetime | None = None) -> FeatureRow:
    if ts is None:
        ts = datetime.now(timezone.utc)
    return FeatureRow(
        amount=float(amount),
        hour=int(ts.hour),
        day_of_week=int(ts.weekday()),  # matches pandas dt.dayofweek
        month=int(ts.month),
    )

def to_dict(fr: FeatureRow) -> Dict[str, Any]:
    return {
        "amount": fr.amount,
        "hour": fr.hour,
        "day_of_week": fr.day_of_week,
        "month": fr.month,
    }
