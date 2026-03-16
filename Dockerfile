FROM python:3.11-slim

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends curl && rm -rf /var/lib/apt/lists/*

COPY pyproject.toml README.md LICENSE ./
COPY src/ ./src/
COPY run_server.py ./

RUN pip install --no-cache-dir -e .

ENV NCBI_EMAIL=agenthung849@gmail.com
ENV MCP_PORT=8080
ENV MCP_HOST=0.0.0.0

EXPOSE 8080

CMD ["python", "run_server.py", "--transport", "sse", "--port", "8080"]
