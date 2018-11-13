include .env
export

ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
BASE_COMPOSE:=docker-compose -f $(ROOT_DIR)/docker-compose.yml
OVERRIDE_COMPOSE:=-f $(ROOT_DIR)/docker-compose.override.yml
DEVOPS_COMPOSE:=-f $(ROOT_DIR)/devops/docker-compose.yml
DATAFLOW_COMPOSE:=-f $(ROOT_DIR)/dataflow/docker-compose.yml
STORAGE_COMPOSE:=-f $(ROOT_DIR)/storage/docker-compose.yml
TOOL_COMPOSE:=-f $(ROOT_DIR)/tool/docker-compose.yml
ELASTIC_COMPOSE:=-f $(ROOT_DIR)/elastic/docker-compose.yml
APP_COMPOSE:=-f $(ROOT_DIR)/app/docker-compose.yml
DEVOPS_SERVICES=portainer jenkins
DATAFLOW_SERVICES=rabbitmq streamsets
STORAGE_SERVICES=mysql redis sftp-server
TOOL_SERVICES=wireshark mailcatcher adminer sqlpad redis-commander redis-memtier_benchmark
ELASTIC_SERVICES=elasticsearch kibana logstash logspout-logstash
SYMFONY_SERVICES=sf_php sf_apache
APP_SERVICES=$(SYMFONY_SERVICES)
UID:=$(shell id -u)
GID:=$(shell id -g)
SF_DIR:=$(ROOT_DIR)/app/symfony

# Global
build:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(APP_COMPOSE) $(OVERRIDE_COMPOSE) build $(services)

up:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(APP_COMPOSE) $(OVERRIDE_COMPOSE) up -d $(services)

stop:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(APP_COMPOSE) $(OVERRIDE_COMPOSE) stop $(services)

down:
ifeq ($(services),)
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(APP_COMPOSE) $(OVERRIDE_COMPOSE) down -v
else
	@for service in $(services); do docker container rm -v -f "$(COMPOSE_PROJECT_NAME)_$${service}"; docker volume rm -f "$(COMPOSE_PROJECT_NAME)_$${service}_data"; done
endif

# Devops Stack
build-devops-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(APP_COMPOSE) $(OVERRIDE_COMPOSE) build $(DEVOPS_SERVICES)

up-devops-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(APP_COMPOSE) $(OVERRIDE_COMPOSE) up -d $(DEVOPS_SERVICES)

stop-devops-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(APP_COMPOSE) $(OVERRIDE_COMPOSE) stop $(DEVOPS_SERVICES)

down-devops-stack:
	@for service in $(DEVOPS_SERVICES); do docker container rm -v -f "$(COMPOSE_PROJECT_NAME)_$${service}"; docker volume rm -f "$(COMPOSE_PROJECT_NAME)_$${service}_data"; done

# Dataflow Stack
build-dataflow-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(APP_COMPOSE) $(OVERRIDE_COMPOSE) build $(DATAFLOW_SERVICES)

up-dataflow-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(APP_COMPOSE) $(OVERRIDE_COMPOSE) up -d $(DATAFLOW_SERVICES)

stop-dataflow-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(APP_COMPOSE) $(OVERRIDE_COMPOSE) stop $(DATAFLOW_SERVICES)

down-dataflow-stack:
	@for service in $(DATAFLOW_SERVICES); do docker container rm -v -f "$(COMPOSE_PROJECT_NAME)_$${service}"; docker volume rm -f "$(COMPOSE_PROJECT_NAME)_$${service}_data"; done

# Storage Stack
build-storage-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(APP_COMPOSE) $(OVERRIDE_COMPOSE) build $(STORAGE_SERVICES)

up-storage-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(APP_COMPOSE) $(OVERRIDE_COMPOSE) up -d $(STORAGE_SERVICES)

stop-storage-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(APP_COMPOSE) $(OVERRIDE_COMPOSE) stop $(STORAGE_SERVICES)

down-storage-stack:
	@for service in $(STORAGE_SERVICES); do docker container rm -v -f "$(COMPOSE_PROJECT_NAME)_$${service}"; docker volume rm -f "$(COMPOSE_PROJECT_NAME)_$${service}_data"; done

# Tool Stack
build-tool-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(APP_COMPOSE) $(OVERRIDE_COMPOSE) build $(TOOL_SERVICES)

up-tool-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(APP_COMPOSE) $(OVERRIDE_COMPOSE) up -d $(TOOL_SERVICES)

stop-tool-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(APP_COMPOSE) $(OVERRIDE_COMPOSE) stop $(TOOL_SERVICES)

down-tool-stack:
	@for service in $(TOOL_SERVICES); do docker container rm -v -f "$(COMPOSE_PROJECT_NAME)_$${service}"; docker volume rm -f "$(COMPOSE_PROJECT_NAME)_$${service}_data"; done

# Elastic Stack
build-elastic-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(APP_COMPOSE) $(OVERRIDE_COMPOSE) build $(ELASTIC_SERVICES)

up-elastic-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(APP_COMPOSE) $(OVERRIDE_COMPOSE) up -d $(ELASTIC_SERVICES)

stop-elastic-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(APP_COMPOSE) $(OVERRIDE_COMPOSE) stop $(ELASTIC_SERVICES)

down-elastic-stack:
	@for service in $(ELASTIC_SERVICES); do docker container rm -v -f "$(COMPOSE_PROJECT_NAME)_$${service}"; docker volume rm -f "$(COMPOSE_PROJECT_NAME)_$${service}_data"; done

# App Stack
build-app-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(APP_COMPOSE) $(OVERRIDE_COMPOSE) build $(APP_SERVICES)

up-app-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(APP_COMPOSE) $(OVERRIDE_COMPOSE) up -d $(APP_SERVICES)

stop-app-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(APP_COMPOSE) $(OVERRIDE_COMPOSE) stop $(APP_SERVICES)

down-app-stack:
	@for service in $(APP_SERVICES); do docker container rm -v -f "$(COMPOSE_PROJECT_NAME)_$${service}"; docker volume rm -f "$(COMPOSE_PROJECT_NAME)_$${service}_data"; done

# App Stack
build-sf-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(APP_COMPOSE) $(OVERRIDE_COMPOSE) build $(SYMFONY_SERVICES)

up-sf-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(APP_COMPOSE) $(OVERRIDE_COMPOSE) up -d $(SYMFONY_SERVICES)

stop-sf-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(APP_COMPOSE) $(OVERRIDE_COMPOSE) stop $(SYMFONY_SERVICES)

down-sf-stack:
	@for service in $(SYMFONY_SERVICES); do docker container rm -v -f "$(COMPOSE_PROJECT_NAME)_$${service}"; docker volume rm -f "$(COMPOSE_PROJECT_NAME)_$${service}_data"; done

bash:
	docker exec -ti --user=root $(COMPOSE_PROJECT_NAME)_$(service) bash

redis_import_data:
	docker exec --user=root $(COMPOSE_PROJECT_NAME)_redis mass_insertion $(args)

redis_memtier_benchmark:
	docker exec --user=root $(COMPOSE_PROJECT_NAME)_redis-memtier_benchmark /opt/memtier_benchmark $(options)

sf-install:
	mkdir -p $(ROOT_DIR)/app/tmp
	cp -Rp $(SF_DIR)/docker $(ROOT_DIR)/app/tmp/.
	cp -Rp $(SF_DIR)/templates/index.html.twig $(ROOT_DIR)/app/tmp/.
	cp -Rp $(SF_DIR)/src/Controller/DefaultController.php $(ROOT_DIR)/app/tmp/.
	cp -Rp $(SF_DIR)/.env.dist $(ROOT_DIR)/app/tmp/.
	rm -Rf $(SF_DIR)/*
	cp -Rp $(ROOT_DIR)/app/tmp/docker $(SF_DIR)/.
	mkdir -p $(SF_DIR)/templates && cp -Rp $(ROOT_DIR)/app/tmp/index.html.twig $(SF_DIR)/templates/.
	mkdir -p $(SF_DIR)/src/Controller && cp -Rp $(ROOT_DIR)/app/tmp/DefaultController.php $(SF_DIR)/src/Controller/.
	cp -Rp $(ROOT_DIR)/app/tmp/.env.dist $(SF_DIR)/.
	rm -Rf $(ROOT_DIR)/app/tmp/docker $(ROOT_DIR)/app/tmp/.env.dist $(ROOT_DIR)/app/tmp/index.html.twig $(ROOT_DIR)/app/tmp/DefaultController.php
	docker run --rm --interactive --tty \
        --volume $(ROOT_DIR)/app:/app \
        --user $(UID):$(GID) \
        composer /bin/bash -c \
        "composer create-project 'symfony/skeleton:$(SYMFONY_VERSION)' tmp --prefer-dist --no-progress --no-interaction && \
        cd tmp && \
        composer update && \
        composer require symfony/dotenv && \
        composer require symfony/monolog-bundle && \
        composer require --dev symfony/profiler-pack && \
        composer require encore && \
        composer require twig"
	sed -i -e 's/#//' $(ROOT_DIR)/app/tmp/config/routes.yaml
	cp -Rp $(ROOT_DIR)/app/tmp/. $(SF_DIR)/.
	rm -Rf $(ROOT_DIR)/app/tmp
	docker container run --rm -it -u $(UID):$(GID) -v $(SF_DIR):/app -w /app node:10-alpine yarn install
