FROM python:3.8-alpine

RUN apk update && apk add build-base postgresql-dev

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
ADD requirements/base.txt ./requirements.txt
RUN  pip install -r requirements.txt
COPY . /usr/src/app

ENTRYPOINT ["sh", "docker-entrypoint.sh"]
