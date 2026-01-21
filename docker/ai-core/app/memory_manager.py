class MemoryManager:
    def __init__(self):
        self.history = []

    def store_interaction(self, text: str):
        self.history.append(text)
        if len(self.history) > 20:  # keep recent context
            self.history.pop(0)

    def get_context(self):
        return " ".join(self.history)
