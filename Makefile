DEFAULT_PY_VERSION=3.7.0
CC=python
DOCKER_COMPOSE=docker-compose
DEFAULT_HOST=localhost:8000
MANAGE_PATH=src/manage.py
REQUIREMENTS_PATH=requirements.txt
DEV_REQUIREMENTS_PATH=requirements/dev.txt

# If the first argument is "docker-up"...
ifeq (docker-up,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "run"
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(RUN_ARGS):;@:)
endif


.PHONY: build clean test help default
default: test

help:
	@echo 'Management commands for Django project:'
	@echo
	@echo 'Usage:'
	@echo '    make test            	Run tests on the project.'
	@echo '    make clean           	Clean the directory tree.'
	@echo '    make run             	Run Django server.'
	@echo '    make docker-up       	Run docker with RUN_ARGS or all by default.'
	@echo '    make install-req     	Install default requirements.'
	@echo '    make install-dev-req 	Install default requirements and dev requirements.'
	@echo '    make install-python  	Install python ${DEFAULT_PY_VERSION}'
	@echo


clean:
	find . -name "*.pyc" -exec rm -f {} \;


test:
	pytest


run: clean
	${CC} ${MANAGE_PATH} runserver ${DEFAULT_HOST}


docker-up: 
	${DOCKER_COMPOSE} up $(RUN_ARGS)


install-req: 
	${CC} -m pip install -r ${REQUIREMENTS_PATH}


install-dev-req: install-req
	${CC} -m pip install -r ${DEV_REQUIREMENTS_PATH}


info:
	$(info shell 'PATH' is ${PATH})


check-binaries:
    EXECUTABLES = docker python pyenv brew
	K := $(foreach exec,$(EXECUTABLES),\
			$(if $(shell which $(exec)),some string,$(error "No $(exec) in PATH")))

install-python: info check-binaries
	-pyenv install ${DEFAULT_PY_VERSION}
	test -f .python-version && rm .python-version
	echo ${DEFAULT_PY_VERSION} >> .python-version
