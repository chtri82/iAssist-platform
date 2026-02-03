# iAssist-platform (Public)
Open-source infrastructure and orchestration layer for iAssist.

Includes:
- API Gateway (C#/.NET)
- AI Core (FastAPI interface)
- Analytics (R / Plumber)
- Airflow Orchestration
- Postgres Database
- Setup & Deployment scripts

## ⚙️ Running iAssist Platform

The platform provides a full local orchestration environment with isolated microservices and self-healing management through the bash manager script.

| Command | Description |
|----------|--------------|
| `./iAssist_manager.sh start` | Start all services + health checks |
| `./iAssist_manager.sh start --logs` | Start + stream logs live |
| `./iAssist_manager.sh stop` | Stop all services |
| `./iAssist_manager.sh rebuild` | Full rebuild (fresh containers) |
| `./iAssist_manager.sh status` | Show running container info |
| `./iAssist_manager.sh clean --force` | Remove all containers, volumes, networks |

---

########################################################################################################

# iAssist-intelligence (Private)
This private repository contains the proprietary AI intelligence layer for iAssist-Platform.

Includes:
- Memory management
- Self-training pipelines
- Model fine-tuning
- Web crawling and data ingestion
- LLM orchestration

Kept private. Licensed for internal R&D use only.
