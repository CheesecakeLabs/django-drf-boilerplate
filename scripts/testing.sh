#!/bin/sh
set -e
set -u

pip install -r requirements/dev.txt
python src/manage.py collectstatic --noinput

coverage erase
coverage run -m pytest -s
coverage report
coverage xml -i