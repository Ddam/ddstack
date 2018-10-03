ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
UID:=$(shell id -u)
GID:=$(shell id -g)

build:
	docker-compose build $(service)

up:
	docker-compose up -d $(service)

stop:
	docker-compose stop $(service)

down:
ifeq ($(service),)
	docker-compose down -v
else
	docker container rm -v -f $(service)
	docker volume rm -f devtools_$(service)_data
endif

bash:
	docker-compose exec --user=root $(service) bash

redis_import_data:
	docker-compose exec -T --user=root redis mass_insertion $(args)

redis_memtier_benchmark:
	docker-compose exec -T --user=root redis-memtier_benchmark /opt/memtier_benchmark $(options)
