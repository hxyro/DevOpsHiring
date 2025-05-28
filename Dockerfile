FROM python:3.10-alpine

# Build argument to control the environment (default to production)
ARG APP_ENV=production


# Set static environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set application-specific environment variables
# These can be overridden at runtime if needed
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0
ENV FLASK_RUN_PORT=5001
ENV APP_ENV=${APP_ENV}
ENV FLASK_ENV=${APP_ENV}

WORKDIR /app

# Create a non-root user and group for better security
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copy requirements files
COPY requirements.txt .

# Install base dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entrypoint script and make it executable
COPY --chown=appuser:appgroup entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY --chown=appuser:appgroup app.py .

# Switch to the non-root user
USER appuser


# Expose the port the app runs on
EXPOSE 5001

# Add a HEALTHCHECK instruction (targets /health endpoint in app.py)
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:${FLASK_RUN_PORT}/health || exit 1

# Use the entrypoint script to start the application
ENTRYPOINT ["/entrypoint.sh"]