import requests
import json
import logging

class Orchestrator:
    def __init__(self):
        # URL of the R Analytics service (inside Docker network)
        self.r_service_url = "http://r-analytics:8000"
        logging.basicConfig(level=logging.INFO)
        self.logger = logging.getLogger("Orchestrator")

    def process(self, user_input: str):
        """
        Main logic for handling user commands.
        Determines intent and routes to the correct analytical module.
        """
        self.logger.info(f"Received user input: {user_input}")

        # Basic command routing (expand later with NLP/intents)
        if "forecast" in user_input.lower():
            result = self._call_r_forecast({"value": 42})  # Example input
        elif "summary" in user_input.lower():
            result = self._call_r_summary({"numbers": [10, 20, 30, 40, 50]})
        else:
            result = f"I didn't understand the request '{user_input}', but I’m learning!"

        self.logger.info(f"Response: {result}")
        return result

    def _call_r_forecast(self, payload: dict):
        """
        Send forecast request to R Analytics.
        """
        try:
            url = f"{self.r_service_url}/forecast"
            response = requests.post(url, json=payload, timeout=10)
            response.raise_for_status()
            data = response.json()
            return f"Forecast result: {data.get('result', 'No result received')}"
        except Exception as e:
            self.logger.error(f"Error calling R Analytics /forecast: {e}")
            return f"Error communicating with R Analytics service: {e}"

    def _call_r_summary(self, payload: dict):
        """
        Send numeric summary request to R Analytics.
        """
        try:
            url = f"{self.r_service_url}/summary"
            response = requests.post(url, json=payload, timeout=10)
            response.raise_for_status()
            data = response.json()
            return f"Summary statistics: {json.dumps(data, indent=2)}"
        except Exception as e:
            self.logger.error(f"Error calling R Analytics /summary: {e}")
            return f"Error communicating with R Analytics service: {e}"
