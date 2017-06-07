RAILS_CONTAINER := web

.PHONY: all
all: run

.PHONY: run
run:
	docker-compose up --build

.PHONY: open
open:
	open http://localhost:3000

.PHONY: build
build:
	docker-compose build

.PHONY: console
console:
	docker-compose run ${RAILS_CONTAINER} rails console

.PHONY: db_create
db_create:
	docker-compose run ${RAILS_CONTAINER} rake db:create

.PHONY: db_migrate
db_migrate:
	docker-compose run ${RAILS_CONTAINER} rake db:migrate

.PHONY: test
test:
	docker-compose up -d operationcode-psql
	while ! docker-compose run -T --rm operationcode-psql psql --host=operationcode-psql --username=postgres -c 'SELECT 1'; do echo 'Waiting for postgres...'; sleep 1; done
	docker-compose run ${RAILS_CONTAINER} bash -c 'export RAILS_ENV=test && rake db:test:prepare && rake db:seed && rake test'

.PHONY: bundle
bundle:
	docker-compose run ${RAILS_CONTAINER} bash -c 'cd /app && bundle'

setup: build db_create db_migrate

publish: build
	bin/publish

travis: build test
