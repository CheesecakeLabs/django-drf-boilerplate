FROM python:3.8-alpine

RUN apk update && apk add build-base postgresql-dev libffi-dev

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY . /usr/src/app

RUN  pip install -r requirements.txt

ENTRYPOINT ["sh", "docker-entrypoint.sh"]
