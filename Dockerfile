FROM python:3.8-alpine

RUN apk update && apk add build-base postgresql-dev jpeg-dev zlib-dev

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY . /usr/src/app

RUN  python -m pip install -U pip && pip install -r requirements.txt

ENTRYPOINT ["sh", "docker-entrypoint.sh"]
