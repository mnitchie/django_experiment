# Variables
compose_dev = ./dev/docker-compose.yml
compose_local = ./docker-compose.yml
dev_service = django_experiment_dev
django_service = django_experiment-runserver

# Recipes: Default
.DEFAULT_GOAL := help

# Recipes: Phony ("not a file")
.PHONY : help $\
	autoflake \
	black \
	clean \
	develop \
	down \
	flake8 \
	flake8-disable-noqa \
	help \
	makemigrations \
	migrate \
	repl \
	repl-server \
	setup \
	shell \
	shell-server \
	sort-imports \
	start \
	test \
	up


#######################
# Development Targets
#######################

# Recipes: Aliases
down: clean ## (alias for "clean")
up: start ## (alias for "start")

# Recipes: Actual
autoflake: ## Automatically removes some unused imports (those in the stdlib and defined by --imports)
	docker-compose -f $(compose_dev) run --build --rm -T $(dev_service) autoflake -r \
	django_experiment/ \
	--imports=typing,rest_framework,django \
	--in-place

black: ## Runs black code formatter
	docker-compose -f $(compose_dev) run --build --rm -T $(dev_service) black --config pyproject.toml django_experiment/

clean: # Removes dev and local containers and associated resources
	@docker-compose -f $(compose_dev) down
	@docker-compose -f $(compose_local) down

develop: # Start up a development container that will run persistently in the background.
	@docker-compose -f $(compose_dev) up -d --build

flake8: # Runs flake8
	docker-compose -f $(compose_dev) run --build --rm -T $(dev_service) flake8 --config .flake8 strata_data_api/

flake8-disable-noqa: # Runs flake8 and shows all the things we're ignoring inline
	docker-compose -f $(compose_dev) run --build --rm -T $(dev_service) flake8 --config .flake8 --disable-noqa strata_data_api/

help: ## show help
	@echo "Usage: make [recipe]\n\nRecipes:"
	@grep -h '##' $(MAKEFILE_LIST) | grep -v grep | sed -e 's/\(.*\):.*## \(.*\)/\1|    \2/' | tr '|' '\n'

makemigrations: ## run django makemigrations inside the local container
	@echo "Making Django migrations"
	@docker-compose -f $(compose_local) run --build --rm $(django_service) bash -c \
	"python manage.py makemigrations"

migrate: ## run django migrations inside the local container
	@echo "Running Django migrations locally"
	@docker-compose -f $(compose_local) run --build --rm $(django_service) bash -c \
	"python manage.py migrate"

repl: ## start REPL inside the development container
	@echo "Starting REPL inside Flask/server ('exit' to quit)..."
	@echo "---"
	@echo "For live reloading and debugging:"
	@echo ""
	@echo "In [1]: %load_ext autoreload"
	@echo "In [2]: %autoreload 2"
	@echo "In [3]: %pdb"
	@echo "---"
	@docker-compose -f $(compose_dev) run --build --rm $(dev_service) ipython

repl-server: ## start REPL inside the local container
	@echo "Starting REPL inside Flask/server ('exit' to quit)..."
	@echo "---"
	@echo "For live reloading and debugging:"
	@echo ""
	@echo "In [1]: %load_ext autoreload"
	@echo "In [2]: %autoreload 2"
	@echo "In [3]: %pdb"
	@echo "---"
	@docker-compose -f $(compose_local) run --build --rm $(django_service) python

setup: ## Install dependencies necessary to work in this repository
	@pre-commit install

shell: develop ## Connect to the shell of the development container
	@echo "Starting a shell in the dev container ('exit' or 'ctrl+d' to quit)"
	@docker-compose -f $(compose_dev) exec $(dev_service) bash

shell-server: ## Connect to the shell of the django/runserver container
	@echo "Starting a shell in the django runserver container ('exit' or 'ctrl+d' to quit)"
	docker-compose -f $(compose_local) run --build --rm $(django_service) bash

sort-imports: ## Sort imports in all python files
	docker-compose -f $(compose_dev) run --build --rm -T $(dev_service) isort . $(ARGS)

start: ## Build and run all local services
	GIT_COMMIT_HASH=$(shell git rev-parse --short HEAD) ./bin/deploy_dev.sh

test: develop ## run unit tests in development container
	@docker-compose -f $(compose_dev) \
	run \
	--rm \
	$(dev_service) \
	bash -c "cd strata_data_api && pytest --junit-xml=test_output/pytest/pytest.xml --ds config.settings.test"
