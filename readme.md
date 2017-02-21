![Cheesecake](https://raw.githubusercontent.com/jonatasbaldin/cake/master/img/logo.png)

# django-drf-boilerplate
Boilerplate project using Django and Django REST Framework.  
Currently supporting only Python 3.x.

**IMPORTANT**:
Make sure you have Django 1.10 installed on your environment.

## How to install

```bash
$ django-admin.py startproject \
  --template=https://github.com/CheesecakeLabs/django-drf-boilerplate/archive/master.zip \
  <project_name> .
$ pip install -r requirements.txt
$ python <project_name>/manage.py runserver
```

## How to install with Docker Compose

```bash
$ django-admin.py startproject \
  --template=https://github.com/CheesecakeLabs/django-drf-boilerplate/archive/master.zip \
  <project_name> .
$ docker-compose up
```

## Database
Running database on latest PostgreSQL Docker container running in the port `5432`. The connection is defined by the `dj-database-url` package. There's a race condition script to avoid running Django before the database goes up.
