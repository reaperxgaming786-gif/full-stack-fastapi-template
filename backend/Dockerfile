FROM python:3.12-slim AS builder

COPY --from=ghcr.io/astral-sh/uv:0.7 /uv /uvx /bin/

ENV UV_COMPILE_BYTECODE=1 
ENV UV_LINK_MODE=copy 
ENV UV_NO_DEV=1 
ENV PYTHONDONTWRITEBYTECODE=1 
ENV PYTHONUNBUFFERED=1

WORKDIR /app

COPY . .

RUN --mount=type=cache,target=/root/.cache/uv uv sync --frozen

# --------------------------------------------------

FROM python:3.12-slim AS runtime

ENV PYTHONDONTWRITEBYTECODE=1 
ENV PYTHONUNBUFFERED=1 
ENV PATH="/app/.venv/bin:$PATH"

WORKDIR /app

RUN groupadd -g 10001 backend && useradd -u 10001 -g backend --system --create-home --shell /usr/sbin/nologin backend

COPY --from=builder --chown=backend:backend /app /app

USER backend

EXPOSE 8000

HEALTHCHECK --interval=30s --timeout=5s --start-period=20s --retries=3 \
   CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:8000/docs')" || exit 1

CMD ["uvicorn","app.main:app","--host","0.0.0.0","--port","8000"]

