FROM python:3.14.10-slim-trixie

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

COPY requirements.txt .

# Update system packages, create a non-root user,
# and install Python dependencies.
RUN set -eux; \
    apt-get update; \
    apt-get upgrade -y; \
    addgroup --system --gid 10001 app; \
    adduser --system --uid 10001 --ingroup app \
    --no-create-home --home /app app; \
    python -m pip install --no-cache-dir --upgrade pip; \
    python -m pip install --no-cache-dir -r requirements.txt; \
    rm -rf /var/lib/apt/lists/*

# Copy application files
COPY --chown=app:app app/ ./app/

# Run as a non-root user
USER app

EXPOSE 8000

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]