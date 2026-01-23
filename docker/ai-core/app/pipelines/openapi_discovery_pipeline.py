import yaml
import requests
import json
import os
import subprocess
from urllib.parse import urljoin

CONFIG_PATH = "config/config_data_sources.yaml"
OUTPUT_DIR = "discovered_endpoints"
CLIENTS_DIR = "app/clients"
REGISTRY_PATH = "app/clients/client_registry.py"

def load_config():
    with open(CONFIG_PATH, "r") as f:
        return yaml.safe_load(f)

def find_openapi(base_domain):
    """
    Attempts to locate OpenAPI or Swagger JSON specs for a given domain.
    """
    common_paths = [
        "/openapi.json", "/swagger.json",
        "/api-docs", "/v1/openapi.json",
        "/docs/json", "/swagger/v1/swagger.json"
    ]
    found = []
    for path in common_paths:
        try:
            url = f"https://{base_domain}{path}"
            r = requests.get(url, timeout=5)
            if r.status_code == 200 and "application/json" in r.headers.get("Content-Type", ""):
                found.append(url)
        except Exception:
            continue
    return found

def fetch_and_save_openapi(url, category):
    """
    Downloads and saves an OpenAPI spec JSON file.
    """
    os.makedirs(os.path.join(OUTPUT_DIR, category), exist_ok=True)
    try:
        r = requests.get(url, timeout=10)
        if r.status_code == 200:
            data = r.json()
            domain = url.split("/")[2].replace(".", "_")
            path = os.path.join(OUTPUT_DIR, category, f"{domain}.json")
            with open(path, "w") as f:
                json.dump(data, f, indent=2)
            print(f"✅ Saved OpenAPI spec: {path}")
            return path
    except Exception as e:
        print(f"⚠️ Failed to fetch {url}: {e}")
    return None

def generate_client(openapi_path, domain_name):
    """
    Uses openapi-python-client to generate a Python client from an OpenAPI JSON file.
    """
    os.makedirs(CLIENTS_DIR, exist_ok=True)
    domain_sanitized = domain_name.replace(".", "_")
    output_path = os.path.join(CLIENTS_DIR, domain_sanitized)

    print(f"🛠️  Generating client for {domain_name}...")

    try:
        subprocess.run([
            "openapi-python-client", "generate",
            "--path", openapi_path,
            "--output-path", output_path,
            "--config", "config/openapi_client_config.yaml"
        ], check=True)
        print(f"✅ Client generated at {output_path}")
        update_client_registry(domain_name, output_path)
    except subprocess.CalledProcessError as e:
        print(f"❌ Client generation failed for {domain_name}: {e}")

def update_client_registry(domain_name, path):
    """
    Updates the central client registry file with a new import and registration entry.
    """
    os.makedirs(os.path.dirname(REGISTRY_PATH), exist_ok=True)

    domain_sanitized = domain_name.replace(".", "_")
    client_module = f"app.clients.{domain_sanitized}.api_client"

    # Initialize registry if missing
    if not os.path.exists(REGISTRY_PATH):
        with open(REGISTRY_PATH, "w") as f:
            f.write("client_registry = {}\n\n")

    # Read existing registry
    with open(REGISTRY_PATH, "r") as f:
        registry_content = f.read()

    if domain_sanitized not in registry_content:
        with open(REGISTRY_PATH, "a") as f:
            f.write(f"from {client_module} import Client as {domain_sanitized}_Client\n")
            f.write(f"client_registry['{domain_name}'] = {domain_sanitized}_Client\n\n")
        print(f"🧩 Added {domain_name} to client registry.")
    else:
        print(f"⚙️  {domain_name} already registered — skipping.")

def run_discovery():
    config = load_config()
    for category, meta in config.items():
        print(f"\n🔍 Scanning category: {category}")
        for domain in meta["approved_domains"]:
            print(f"  Checking {domain}...")
            endpoints = find_openapi(domain)
            for url in endpoints:
                spec_path = fetch_and_save_openapi(url, category)
                if spec_path:
                    generate_client(spec_path, domain)

if __name__ == "__main__":
    run_discovery()
