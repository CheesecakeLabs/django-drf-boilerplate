FROM python:3.6-jessie

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY requirements.txt /usr/src/app/
RUN pip install --no-cache-dir -r requirements.txt

COPY . /usr/src/app
COPY docker-entrypoint.sh /usr/src/app

ENTRYPOINT ["sh", "docker-entrypoint.sh"]
