FROM python:3.5-onbuild

COPY install.sh /usr/src/app

ENTRYPOINT ["sh", "install.sh"]
