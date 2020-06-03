# Django DRF Boilerplate

[![CircleCI](https://circleci.com/gh/CheesecakeLabs/django-drf-boilerplate.svg?style=svg)](https://circleci.com/gh/CheesecakeLabs/django-drf-boilerplate)
[![Maintainability](https://api.codeclimate.com/v1/badges/4e7d4baaeb97d8590475/maintainability)](https://codeclimate.com/github/CheesecakeLabs/django-drf-boilerplate/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/4e7d4baaeb97d8590475/test_coverage)](https://codeclimate.com/github/CheesecakeLabs/django-drf-boilerplate/test_coverage)
[![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)

Boilerplate project using Django and Django REST Framework.
Currently supporting only Python 3.x.

**IMPORTANT**:
Docker Compose is used _just_ for development environment. The Dockerfile works without it.

## How to install with Pyenv

```bash
$ pyenv virtualenv 3.8.0 <project_name>
$ pyenv activate <project_name>
$ pip install Django==2.2.7
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

## Install Black code formatter to your editor

Check code syntax and style before committing changes.

Pre-commit hook may be installed using the following steps:

```bash
$ pip install -r requirements/dev.txt
$ pre-commit install
```

Or run it manually:

```bash
$ black .
```

## Jira issues in commit messages

For automatically adding Jira content to your commit message, install Git's
`prepare-commit-msg` hook.

```bash
pre-commit install --hook-type prepare-commit-msg
```

Set the following `env` keys to your `bash_profile` or `zshenv`.

```bash
# https://cheesecakelabs.atlassian.net
export jiraserver="https://domain.atlassian.net"
export jirauser="your@email.com"

# from: https://id.atlassian.com/manage-profile/security/api-tokens
export jiratoken="token"
```

Finally, in `.pre-commit-config`, add your board name and the regex for your
Jira ID

## Block push on invalid branch name

Git provides a `pre-push` hook, which checks the branch name before pushing to
remote. This prevents pushing branches that do not follow a pattern name.

```bash
pre-commit install --hook-type pre-push
```

Then configure the required regex for branch name in `.pre-commit-config`

## The initial workflow on circleci

Follow those map of branchs and
![](https://i.ibb.co/82xhB1j/Django-Boilerplate-Pipeline-1.jpg)

update the image name at config.yaml and docker-compose.test.yaml

```yaml
references:
  image_name: &image_name organization-name/project-name
```

```yaml
web:
  image: organization-name/project-name
```

don't forget to define these environment variables in your circleci project settings:

- `AWS_ACCOUNT_ID`
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_DEFAULT_REGION` (ex: `us-east-1`)
- `AWS_RESOURCE_NAME_PREFIX` (ex: `${project_name}-backend`)
- `AWS_SERVICE_NAME_LAB` (ex: `${project_name}-backend-lab`)
- `AWS_SERVICE_NAME_STAGING` (ex: `${project_name}-backend-staging`)
- `AWS_SERVICE_NAME_PROD` (ex: `${project_name}-backend-production`)
- `AWS_CLUSTER_NAME_LAB` (ex: `${project_name}-lab`)
- `AWS_CLUSTER_NAME_STAGING` (ex: `${project_name}-staging`)
- `AWS_CLUSTER_NAME_PROD` (ex: `${project_name}-production`)
- `CC_TEST_REPORTER_ID` ([from CodeClimate](https://docs.codeclimate.com/docs/finding-your-test-coverage-token))
- `ENVIRONMENT` (ex: `development`)
- `DJANGO_DEBUG` (ex: `True`)
- `DJANGO_ALLOWED_HOSTS` (ex: `*,`)
- `DJANGO_SECRET_KEY`

## Database

Running database on latest PostgreSQL Docker container running in the port `5432`. The connection is defined by the `dj-database-url` package. There's a race condition script to avoid running Django before the database goes up.

## Handling Business Error

```
from helpers.business_errors import BusinessException, EXAMPLE_ERROR
...
if logic_check:
    raise BusinessException(error_code=EXAMPLE_ERROR)
```

`BusinessException` extends `APIException` (Django Rest Framework) and `ValidationError` (Django), so it is handled by their middlewares by default.

## Docs

Let's face it, human memory sucks. Will you remember every detail that involves your project 6 months from now? How about when the pressure is on? A project with good documentation that explains all the facets, interactions and architectural choices means you and your teammates won't have to spend hours trying to figure it out later. You can find a template to get started [here](https://github.com/CheesecakeLabs/django-drf-boilerplate/wiki/Docs-Template).
