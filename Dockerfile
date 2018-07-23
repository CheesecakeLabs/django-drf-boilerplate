FROM python:3.6-jessie

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY . /usr/src/app

RUN pip install --upgrade pip pipenv
RUN set -ex && pipenv install --deploy --system

ENTRYPOINT ["sh", "docker-entrypoint.sh"]
