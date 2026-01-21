from modules.finance_agent import FinanceAgent
from modules.home_agent import HomeAgent
from modules.health_agent import HealthAgent
from memory_manager import MemoryManager

class Orchestrator:
    def __init__(self):
        self.memory = MemoryManager()
        self.finance = FinanceAgent()
        self.home = HomeAgent()
        self.health = HealthAgent()

    def process(self, user_input: str) -> str:
        """Core reasoning and routing logic"""
        self.memory.store_interaction(user_input)

        # Example basic intent routing
        if "budget" in user_input or "money" in user_input:
            return self.finance.handle_request(user_input)
        elif "light" in user_input or "temperature" in user_input:
            return self.home.handle_request(user_input)
        elif "health" in user_input or "calories" in user_input:
            return self.health.handle_request(user_input)
        else:
            return "I'm analyzing your request — please provide more context."
