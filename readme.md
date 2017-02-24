![Cheesecake](https://raw.githubusercontent.com/jonatasbaldin/cake/master/img/logo.png)

# django-drf-boilerplate
Boilerplate project using Django and Django REST Framework.  
Currently supporting only Python 3.x.

Make sure you have Django 1.10 installed on your environment.

## How to install

```bash
$ django-admin.py startproject \
  --template=https://github.com/CheesecakeLabs/django-drf-boilerplate/archive/master.zip \
  <project_name> .
$ pip install -r requirements.txt
$ python <project_name>/manage.py runserver
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
