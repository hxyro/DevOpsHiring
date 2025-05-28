#!/bin/sh
# entrypoint.sh

# Exit immediately if a command exits with a non-zero status.
set -e

# Print the environment mode
echo "Running in $APP_ENV mode (FLASK_ENV=$FLASK_ENV)"

# Run The Flask application using Gunicorn
exec gunicorn --bind "${FLASK_RUN_HOST}:${FLASK_RUN_PORT}" app:app