include Makefile.in

.PHONY: all
all: run 

.PHONY: setup
setup: build db_create db_migrate

.PHONY: console-sandbox
console-sandbox:
	$(DOCKER_COMPOSE) run $(RAILS_CONTAINER) rails console --sandbox

.PHONY: run
run:
	$(DOCKER_COMPOSE) up --build

.PHONY: bg
bg:
	$(DOCKER_COMPOSE) up --build -d

.PHONY: open
open:
	open http://localhost:3000

.PHONY: build
build:
	$(DOCKER_COMPOSE) build

.PHONY: console
console:
	$(DOCKER_COMPOSE) run $(RAILS_CONTAINER) rails console

.PHONY: routes
routes:
	$(DOCKER_COMPOSE) run $(RAILS_CONTAINER) rake routes

.PHONY: bundle
bundle:
	$(DOCKER_COMPOSE) run $(RAILS_CONTAINER) bash -c 'cd /app && bundle'



#### Database Targets
.PHONY: db_create
db_create:
	$(DOCKER_COMPOSE) run $(RAILS_CONTAINER) rake db:create

.PHONY: db_migrate
db_migrate:
	$(DOCKER_COMPOSE) run $(RAILS_CONTAINER) rake db:migrate

.PHONY: db_status
db_status:
	$(DOCKER_COMPOSE) run $(RAILS_CONTAINER) rake db:migrate:status

.PHONY: db_rollback
db_rollback:
	$(DOCKER_COMPOSE) run $(RAILS_CONTAINER) rake db:rollback

.PHONY: db_seed
db_seed:
	$(DOCKER_COMPOSE) run $(RAILS_CONTAINER) rake db:seed

#### Tests and Linting
.PHONY: test
test: bg
	$(DOCKER_COMPOSE) run operationcode-psql bash -c "while ! psql --host=operationcode-psql --username=postgres -c 'SELECT 1'; do sleep 5; done;"
	$(DOCKER_COMPOSE) run $(RAILS_CONTAINER) bash -c 'export RAILS_ENV=test && rake db:test:prepare && rake test || echo -e "$(RED)Unit tests have failed$(NC)" '
	$(DOCKER_COMPOSE) run $(RAILS_CONTAINER) bash -c 'rubocop' || echo -e "$(RED)Linting has failed$(NC)"

.PHONY: rubocop
rubocop:
	$(DOCKER_COMPOSE) run $(RAILS_CONTAINER) rubocop

.PHONY: rubocop_auto_correct
rubocop_auto_correct:
	$(DOCKER_COMPOSE) run $(RAILS_CONTAINER) rubocop -a --auto-correct


#### Cleanup Targets
.PHONY: nuke
nuke: 
	$(DOCKER) system prune -a --volumes

.PHONY:
minty-fresh: 
	$(DOCKER_COMPOSE) down --rmi all --volumes

.PHONY: rmi
rmi: 
	$(DOCKER) images -q | xargs docker rmi -f

.PHONY: rmdi
rmdi: 
	$(DOCKER) images -a --filter=dangling=true -q | xargs $(DOCKER) rmi

.PHONY: rm-exited-containers
rm-exited-containers: 
	$(DOCKER) ps -a -q -f status=exited | xargs $(DOCKER) rm -v 

.PHONY: fresh-restart
fresh-restart: minty-fresh setup test run


#### Deployment targets
publish: build
	bin/publish

upgrade: publish
	bin/deploy
