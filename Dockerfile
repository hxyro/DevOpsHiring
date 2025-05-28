FROM python:3.10-alpine

# Set static environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

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

# Use the entrypoint script to start the application
ENTRYPOINT ["/entrypoint.sh"]