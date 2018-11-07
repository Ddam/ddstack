include .env
export

ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
BASE_COMPOSE:=docker-compose -f $(ROOT_DIR)/docker-compose.yml -f $(ROOT_DIR)/docker-compose.override.yml
DEVOPS_COMPOSE:=-f $(ROOT_DIR)/devops/docker-compose.yml
DATAFLOW_COMPOSE:=-f $(ROOT_DIR)/dataflow/docker-compose.yml
STORAGE_COMPOSE:=-f $(ROOT_DIR)/storage/docker-compose.yml
TOOL_COMPOSE:=-f $(ROOT_DIR)/tool/docker-compose.yml
ELASTIC_COMPOSE:=-f $(ROOT_DIR)/elastic/docker-compose.yml
WEB_COMPOSE:=-f $(ROOT_DIR)/web/docker-compose.yml
DEV_COMPOSE:=-f $(ROOT_DIR)/dev/docker-compose.yml
DEVOPS_SERVICES=portainer jenkins
DATAFLOW_SERVICES=rabbitmq streamsets
STORAGE_SERVICES=mysql adminer sqlpad redis redis-commander redis-memtier_benchmark sftp-server
TOOL_SERVICES=wireshark mailcatcher
ELASTIC_SERVICES=elasticsearch kibana logstash logspout-logstash
WEB_SERVICES=apache
DEV_SERVICES=php
UID:=$(shell id -u)
GID:=$(shell id -g)

# Global
build:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(WEB_COMPOSE) $(DEV_COMPOSE) build $(services)

up:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(WEB_COMPOSE) $(DEV_COMPOSE) up -d $(services)

stop:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(WEB_COMPOSE) $(DEV_COMPOSE) stop $(services)

down:
ifeq ($(services),)
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(WEB_COMPOSE) $(DEV_COMPOSE) down -v
else
	@for service in $(services); do docker container rm -v -f "$(COMPOSE_PROJECT_NAME)_$${service}"; docker volume rm -f "$(COMPOSE_PROJECT_NAME)_$${service}_data"; done
endif

# Devops Stack
build-devops-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(WEB_COMPOSE) $(DEV_COMPOSE) build $(DEVOPS_SERVICES)

up-devops-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(WEB_COMPOSE) $(DEV_COMPOSE) up -d $(DEVOPS_SERVICES)

stop-devops-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(WEB_COMPOSE) $(DEV_COMPOSE) stop $(DEVOPS_SERVICES)

down-devops-stack:
	@for service in $(DEVOPS_SERVICES); do docker container rm -v -f "$(COMPOSE_PROJECT_NAME)_$${service}"; docker volume rm -f "$(COMPOSE_PROJECT_NAME)_$${service}_data"; done

# Dataflow Stack
build-dataflow-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(WEB_COMPOSE) $(DEV_COMPOSE) build $(DATAFLOW_SERVICES)

up-dataflow-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(WEB_COMPOSE) $(DEV_COMPOSE) up -d $(DATAFLOW_SERVICES)

stop-dataflow-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(WEB_COMPOSE) $(DEV_COMPOSE) stop $(DATAFLOW_SERVICES)

down-dataflow-stack:
	@for service in $(DATAFLOW_SERVICES); do docker container rm -v -f "$(COMPOSE_PROJECT_NAME)_$${service}"; docker volume rm -f "$(COMPOSE_PROJECT_NAME)_$${service}_data"; done

# Storage Stack
build-storage-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(WEB_COMPOSE) $(DEV_COMPOSE) build $(STORAGE_SERVICES)

up-storage-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(WEB_COMPOSE) $(DEV_COMPOSE) up -d $(STORAGE_SERVICES)

stop-storage-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(WEB_COMPOSE) $(DEV_COMPOSE) stop $(STORAGE_SERVICES)

down-storage-stack:
	@for service in $(STORAGE_SERVICES); do docker container rm -v -f "$(COMPOSE_PROJECT_NAME)_$${service}"; docker volume rm -f "$(COMPOSE_PROJECT_NAME)_$${service}_data"; done

# Tool Stack
build-tool-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(WEB_COMPOSE) $(DEV_COMPOSE) build $(TOOL_SERVICES)

up-tool-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(WEB_COMPOSE) $(DEV_COMPOSE) up -d $(TOOL_SERVICES)

stop-tool-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(WEB_COMPOSE) $(DEV_COMPOSE) stop $(TOOL_SERVICES)

down-tool-stack:
	@for service in $(TOOL_SERVICES); do docker container rm -v -f "$(COMPOSE_PROJECT_NAME)_$${service}"; docker volume rm -f "$(COMPOSE_PROJECT_NAME)_$${service}_data"; done

# Elastic Stack
build-elastic-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(WEB_COMPOSE) $(DEV_COMPOSE) build $(ELASTIC_SERVICES)

up-elastic-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(WEB_COMPOSE) $(DEV_COMPOSE) up -d $(ELASTIC_SERVICES)

stop-elastic-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(WEB_COMPOSE) $(DEV_COMPOSE) stop $(ELASTIC_SERVICES)

down-elastic-stack:
	@for service in $(ELASTIC_SERVICES); do docker container rm -v -f "$(COMPOSE_PROJECT_NAME)_$${service}"; docker volume rm -f "$(COMPOSE_PROJECT_NAME)_$${service}_data"; done

# Web Stack
build-web-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(WEB_COMPOSE) $(DEV_COMPOSE) build $(WEB_SERVICES)

up-web-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(WEB_COMPOSE) $(DEV_COMPOSE) up -d $(WEB_SERVICES)

stop-web-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(WEB_COMPOSE) $(DEV_COMPOSE) stop $(WEB_SERVICES)

down-web-stack:
	@for service in $(WEB_SERVICES); do docker container rm -v -f "$(COMPOSE_PROJECT_NAME)_$${service}"; docker volume rm -f "$(COMPOSE_PROJECT_NAME)_$${service}_data"; done

# Dev Stack
build-dev-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(WEB_COMPOSE) $(DEV_COMPOSE) build $(DEV_SERVICES)

up-dev-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(WEB_COMPOSE) $(DEV_COMPOSE) up -d $(DEV_SERVICES)

stop-dev-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) $(ELASTIC_COMPOSE) $(WEB_COMPOSE) $(DEV_COMPOSE) stop $(DEV_SERVICES)

down-dev-stack:
	@for service in $(DEV_SERVICES); do docker container rm -v -f "$(COMPOSE_PROJECT_NAME)_$${service}"; docker volume rm -f "$(COMPOSE_PROJECT_NAME)_$${service}_data"; done

bash:
	docker exec -ti --user=root $(COMPOSE_PROJECT_NAME)_$(service) bash

redis_import_data:
	docker exec --user=root $(COMPOSE_PROJECT_NAME)_redis mass_insertion $(args)

redis_memtier_benchmark:
	docker exec --user=root $(COMPOSE_PROJECT_NAME)_redis-memtier_benchmark /opt/memtier_benchmark $(options)

set-www-data-permissions:
	docker exec --user=root $(COMPOSE_PROJECT_NAME)_php chown -R www-data. .
	docker exec --user=root $(COMPOSE_PROJECT_NAME)_apache chown -R www-data. .

sf4-install:
	docker cp app/sf4/. ${COMPOSE_PROJECT_NAME}_php:/var/www/html
	docker cp app/sf4/. ${COMPOSE_PROJECT_NAME}_apache:/var/www/html
	make set-www-data-permissions

sf4-ci:
	docker exec --user=www-data $(COMPOSE_PROJECT_NAME)_php composer install -o

sf4-cu:
	docker exec --user=www-data $(COMPOSE_PROJECT_NAME)_php composer update

sf4-cr:
	docker exec --user=www-data $(COMPOSE_PROJECT_NAME)_php composer require $(bundle)
