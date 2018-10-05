include Makefile.in
all: run

console-sandbox:
	 $(DOCKER_COMPOSE) run $(RAILS_CONTAINER) rails console --sandbox

run:
	$(DOCKER_COMPOSE) up --build

bg:
	$(DOCKER_COMPOSE) up --build -d

open:
	open http://localhost:3000

build:
	$(DOCKER_COMPOSE) build

console:
	$(DOCKER_COMPOSE) run $(RAILS_CONTAINER) rails console

routes:
	$(DOCKER_COMPOSE) run $(RAILS_CONTAINER) rake routes

db_create:
	$(DOCKER_COMPOSE) run $(RAILS_CONTAINER) rake db:create

db_migrate:
	$(DOCKER_COMPOSE) run $(RAILS_CONTAINER) rake db:migrate

db_status:
	$(DOCKER_COMPOSE) run $(RAILS_CONTAINER) rake db:migrate:status

db_rollback:
	$(DOCKER_COMPOSE) run $(RAILS_CONTAINER) rake db:rollback

db_seed:
	$(DOCKER_COMPOSE) run $(RAILS_CONTAINER) rake db:seed

test: bg
	$(DOCKER_COMPOSE) run operationcode-psql bash -c "while ! psql --host=operationcode-psql --username=postgres -c 'SELECT 1'; do sleep 5; done;"
	$(DOCKER_COMPOSE) run $(RAILS_CONTAINER) bash -c 'export RAILS_ENV=test && rake db:test:prepare && rake test && rubocop' || echo -e "$(RED)Tests have failed$(NC)"

rubocop:
	$(DOCKER_COMPOSE) run $(RAILS_CONTAINER) rubocop

rubocop_auto_correct:
	$(DOCKER_COMPOSE) run $(RAILS_CONTAINER) rubocop -a --auto-correct

bundle:
	$(DOCKER_COMPOSE) run $(RAILS_CONTAINER) bash -c 'cd /app && bundle'

setup: build db_create db_migrate

publish: build
	bin/publish

upgrade: publish
	bin/deploy
