RAILS_CONTAINER := web
DOCKER := docker
DOCKER_COMPOSE := docker-compose

.PHONY: all
all: run

.PHONY:  nuke
nuke:
	${DOCKER} system prune -a --volumes

.PHONY: minty-fresh
minty-fresh:
	${DOCKER_COMPOSE} down --rmi all --volumes

.PHONY: rmi
rmi:
	${DOCKER} images -q | xargs docker rmi -f

.PHONY: rmdi
rmdi:
	${DOCKER} images -a --filter=dangling=true -q | xargs ${DOCKER} rmi

.PHONY: rm-exited-containers
rm-exited-containers:
	${DOCKER} ps -a -q -f status=exited | xargs ${DOCKER} rm -v

.PHONY: fresh-restart
fresh-restart: minty-fresh setup test run

.PHONY: console-sandbox
console-sandbox:
	docker-compose run ${RAILS_CONTAINER} bundle exec rails console --sandbox

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
	docker-compose run ${RAILS_CONTAINER} bundle exec rails console

.PHONY: routes
routes:
	docker-compose run ${RAILS_CONTAINER} bundle exec rake routes

.PHONY: db_create
db_create:
	docker-compose run ${RAILS_CONTAINER} bundle exec rake db:create

.PHONY: db_migrate
db_migrate:
	docker-compose run ${RAILS_CONTAINER} bundle exec rake db:migrate

.PHONY: db_status
db_status:
	docker-compose run ${RAILS_CONTAINER} bundle exec rake db:migrate:status

.PHONY: db_rollback
db_rollback:
	docker-compose run ${RAILS_CONTAINER} bundle exec rake db:rollback

.PHONY: db_seed
db_seed:
	docker-compose run ${RAILS_CONTAINER} bundle exec rake db:seed

.PHONY: test
test: bg
	docker-compose run operationcode-psql bash -c "while ! psql --host=operationcode-psql --username=postgres -c 'SELECT 1'; do sleep 5; done;"
	docker-compose run ${RAILS_CONTAINER} bash -c 'export RAILS_ENV=test && bundle exec rake db:test:prepare && bundle exec rake test && bundle exec rubocop'

.PHONY: rubocop
rubocop:
	docker-compose run ${RAILS_CONTAINER} bundle exec rubocop

.PHONY: rubocop_auto_correct
rubocop_auto_correct:
	docker-compose run ${RAILS_CONTAINER} bundle exec rubocop -a --auto-correct

.PHONY: bundle
bundle:
	docker-compose run ${RAILS_CONTAINER} bash -c 'cd /app && bundle'

setup: build db_create db_migrate

publish: build
	bin/publish

upgrade: publish
	bin/deploy
