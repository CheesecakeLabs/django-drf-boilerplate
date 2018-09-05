#!/bin/bash
set -e

if [ "$1" = "manage" ]; then
    shift 1
    exec python src/manage.py "$@"
else
    python docker/web/check_db.py --service-name Postgres --ip db --port 5432

    python src/manage.py migrate                  # Apply database migrations
    python src/manage.py collectstatic --noinput  # Collect static files

    # Prepare log files and start outputting logs to stdout
    mkdir /srv/logs/
    touch /srv/logs/gunicorn.log
    touch /srv/logs/access.log
    tail -n 0 -f /srv/logs/*.log &

    # Start Gunicorn processes
    echo Starting Gunicorn
    exec gunicorn app.wsgi \
        --bind 0.0.0.0:8000 \
        --chdir /usr/src/app/src \
        --workers 3 \
        --log-level=info \
        --log-file=/srv/logs/gunicorn.log \
        --access-logfile=/srv/logs/access.log
fi
