release: python manage.py migrate
web: gunicorn app.wsgi --chdir /app/src --workers 3 --log-level=info --log-file -