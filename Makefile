RAILS_CONTAINER := web

.PHONY: all
all: run

.PHONY: run
run:
	docker-compose up --build

.PHONY: bg
bg:
	docker-compose up --build -d

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
test: bg
	docker-compose run operationcode-psql bash -c "while ! psql --host=operationcode-psql --username=postgres -c 'SELECT 1'; do sleep 5; done;"
	docker-compose run ${RAILS_CONTAINER} bash -c 'export RAILS_ENV=test && rake db:test:prepare && rake db:seed && rake test'

.PHONY: bundle
bundle:
	docker-compose run ${RAILS_CONTAINER} bash -c 'cd /app && bundle'

setup: build db_create db_migrate

publish: build
	bin/publish

upgrade: publish
	bin/rancher_update
