RAILS_CONTAINER := web

.PHONY: all
all: run

.PHONY: console-sandbox
	console-sandbox:
	 docker-compose run ${RAILS_CONTAINER} rails console --sandbox

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

.PHONY: db_status
db_status:
	docker-compose run ${RAILS_CONTAINER} rake db:migrate:status

.PHONY: db_rollback
db_rollback:
	docker-compose run ${RAILS_CONTAINER} rake db:rollback

.PHONY: db_seed
db_seed:
	docker-compose run ${RAILS_CONTAINER} rake db:seed

.PHONY: test
test: bg
	docker-compose run operationcode-psql bash -c "while ! psql --host=operationcode-psql --username=postgres -c 'SELECT 1'; do sleep 5; done;"
	docker-compose run ${RAILS_CONTAINER} bash -c 'export RAILS_ENV=test && rake db:test:prepare && rake test'

.PHONY: bundle
bundle:
	docker-compose run ${RAILS_CONTAINER} bash -c 'cd /app && bundle'

setup: build db_create db_migrate

publish: build
	bin/publish

upgrade: publish
	bin/deploy
