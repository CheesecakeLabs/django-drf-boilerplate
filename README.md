<img src="https://s3-us-west-2.amazonaws.com/ckl-generic-hosting/cheesecake-logo-blue.png" height="60">

# Django DRF Boilerplate
Boilerplate project using Django and Django REST Framework.
Currently supporting only Python 3.x.

**IMPORTANT**:
Docker Compose is used *just* for development environment. The Dockerfile works without it.

## How to install with Pyenv

```bash
$ pyenv virtualenv 3.7.3 <project_name>
$ pyenv activate <project_name>
$ pip install Django==2.2.2
$ django-admin.py startproject \
  --template=https://github.com/CheesecakeLabs/django-drf-boilerplate/archive/master.zip \
  <project_name> .
$ pip install -r requirements/dev.txt
$ python src/manage.py runserver
```

## How to install with Docker Compose

```bash
$ django-admin.py startproject \
  --template=https://github.com/CheesecakeLabs/django-drf-boilerplate/archive/master.zip \
  <project_name> .
$ docker-compose up
```

## Install git pre-commit hook
Check code syntax and style before commit changes.

After initializing git, add flake8 hook.
```bash
$ git init
$ python -m flake8 --install-hook git
```

Set flake8 strict parameter to true, this forces all violations to be fixed
before the commit.
```bash
$ git config --bool flake8.strict true
```

## Database
Running database on latest PostgreSQL Docker container running in the port `5432`. The connection is defined by the `dj-database-url` package. There's a race condition script to avoid running Django before the database goes up.

## Docs
Let's face it, human memory sucks. Will you remember every detail that involves your project 6 months from now? How about when the pressure is on? A project with good documentation that explains all the facets, interactions and architectural choices means you and your teammates won't have to spend hours trying to figure it out later. You can find a template to get started [here](https://github.com/CheesecakeLabs/django-drf-boilerplate/wiki/Docs-Template).
