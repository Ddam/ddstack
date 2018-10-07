include .env
export

ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
BASE_COMPOSE:=docker-compose -f $(ROOT_DIR)/docker-compose.yml -f $(ROOT_DIR)/docker-compose.override.yml
DEVOPS_COMPOSE:=-f $(ROOT_DIR)/devops/docker-compose.yml
DATAFLOW_COMPOSE:=-f $(ROOT_DIR)/dataflow/docker-compose.yml
STORAGE_COMPOSE:=-f $(ROOT_DIR)/storage/docker-compose.yml
TOOL_COMPOSE:=-f $(ROOT_DIR)/tool/docker-compose.yml
DEVOPS_SERVICES=portainer jenkins
DATAFLOW_SERVICES=rabbitmq streamsets
STORAGE_SERVICES=mysql adminer sqlpad redis redis-commander redis-memtier_benchmark elasticsearch sense sftp-server
TOOL_SERVICES=wireshark mailcatcher
UID:=$(shell id -u)
GID:=$(shell id -g)

# Global
build:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) build $(services)

up:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) up -d $(services)

stop:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) stop $(services)

down:
ifeq ($(services),)
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) down -v
else
	@for service in $(services); do docker container rm -v -f "$(COMPOSE_PROJECT_NAME)_$${service}"; docker volume rm -f "$(COMPOSE_PROJECT_NAME)_$${service}_data"; done
endif

# Devops Stack
build-devops-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) build $(DEVOPS_SERVICES)

up-devops-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) up -d $(DEVOPS_SERVICES)

stop-devops-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) stop $(DEVOPS_SERVICES)

down-devops-stack:
	@for service in $(DEVOPS_SERVICES); do docker container rm -v -f "$(COMPOSE_PROJECT_NAME)_$${service}"; docker volume rm -f "$(COMPOSE_PROJECT_NAME)_$${service}_data"; done

# Dataflow Stack
build-dataflow-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) build $(DATAFLOW_SERVICES)

up-dataflow-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) up -d $(DATAFLOW_SERVICES)

stop-dataflow-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) stop $(DATAFLOW_SERVICES)

down-dataflow-stack:
	@for service in $(DATAFLOW_SERVICES); do docker container rm -v -f "$(COMPOSE_PROJECT_NAME)_$${service}"; docker volume rm -f "$(COMPOSE_PROJECT_NAME)_$${service}_data"; done

# Storage Stack
build-storage-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) build $(STORAGE_SERVICES)

up-storage-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) up -d $(STORAGE_SERVICES)

stop-storage-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) stop $(STORAGE_SERVICES)

down-storage-stack:
	@for service in $(STORAGE_SERVICES); do docker container rm -v -f "$(COMPOSE_PROJECT_NAME)_$${service}"; docker volume rm -f "$(COMPOSE_PROJECT_NAME)_$${service}_data"; done

# Tool Stack
build-tool-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) build $(TOOL_SERVICES)

up-tool-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) up -d $(TOOL_SERVICES)

stop-tool-stack:
	$(BASE_COMPOSE) $(DEVOPS_COMPOSE) $(DATAFLOW_COMPOSE) $(STORAGE_COMPOSE) $(TOOL_COMPOSE) stop $(TOOL_SERVICES)

down-tool-stack:
	@for service in $(TOOL_SERVICES); do docker container rm -v -f "$(COMPOSE_PROJECT_NAME)_$${service}"; docker volume rm -f "$(COMPOSE_PROJECT_NAME)_$${service}_data"; done

bash:
	docker exec -ti --user=root $(COMPOSE_PROJECT_NAME)_$(service) bash

redis_import_data:
	docker exec --user=root $(COMPOSE_PROJECT_NAME)_redis mass_insertion $(args)

redis_memtier_benchmark:
	docker exec --user=root $(COMPOSE_PROJECT_NAME)_redis-memtier_benchmark /opt/memtier_benchmark $(options)
