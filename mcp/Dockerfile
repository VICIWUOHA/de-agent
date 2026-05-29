FROM python:3.11-slim

WORKDIR /app

RUN pip install --no-cache-dir mcp-clickhouse

EXPOSE 8000

ENV CLICKHOUSE_MCP_SERVER_TRANSPORT=http \
    CLICKHOUSE_MCP_BIND_HOST=0.0.0.0 \
    CLICKHOUSE_MCP_BIND_PORT=8000 \
    CLICKHOUSE_MCP_AUTH_DISABLED=true

CMD ["mcp-clickhouse"]
 