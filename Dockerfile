FROM python:3.15-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

WORKDIR /app

COPY . /src

RUN pip install --no-cache-dir /src \
    && useradd --system --no-create-home exporter \
    && mkdir -p /app \
    && chown exporter:exporter /app

USER exporter

EXPOSE 8999

CMD ["synapse-prometheus-exporter", "--host", "0.0.0.0", "--port", "8999"]

