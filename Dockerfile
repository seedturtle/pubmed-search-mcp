FROM python:3.11-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy project files
COPY pyproject.toml README.md LICENSE ./
COPY src/ ./src/
COPY run_server.py ./

# Install Python dependencies
RUN pip install --no-cache-dir -e ".[mcp]"

# Default environment variables
ENV NCBI_EMAIL=agenthung849@gmail.com
ENV MCP_PORT=8080
ENV MCP_HOST=0.0.0.0

# Expose port
EXPOSE 8080

# Run the server
CMD ["python", "run_server.py", "--transport", "sse", "--port", "8080"]
