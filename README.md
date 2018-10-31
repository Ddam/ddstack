
# Devtools - Docker Stacks

Here are some stacks of development made in Docker. Rather Web oriented she can help during the development of a Web project :)

## Dependencies

- [Docker 18.06.1](https://docs.docker.com/install/)
- [Docker Compose 1.22.0 (v3.7)](https://docs.docker.com/compose/)

## Description

In this stacks, Traefik is used as a reverse proxy in order to be able to browse the different web applications. You will find below, the different urls of each service (with COMPOSE_PROJECT_NAME variable set to local). Add them to your favorites in your favorite browser ;)

### Traefik

| Service | Name | Frontend | Description |
|:--------|:-----|:---------|:------------|
| [Traefik](https://traefik.io/) | traefik | http://local.traefik.docker/ | Traefik is an HTTP / HTTPS reverse proxy and a load-balancer for the purpose of easily deploying microservices. |

### Devops Stack

| Service | Name | Frontend | Description |
|:--------|:-----|:---------|:------------|
| [Portainer](https://portainer.io/) | portainer | http://local.portainer.docker/ | Portainer is an open-source lightweight management ui which allows you to easily manage your docker hosts or swarm clusters. |
| [Jenkins (PHP Docker build)](https://jenkins.io/) | jenkins | http://local.jenkins.docker/ | As an extensible automation server, Jenkins can be used as a simple CI server or turned into the continuous delivery hub for any project. |
 
### Storage Stack

| Service | Name | Frontend | Description |
|:--------|:-----|:---------|:------------|
| [Mysql](https://www.mysql.com/fr/) | mysql | - | MySQL is an open-source relational database management system (RDBMS). |
| [Adminer](https://www.adminer.org/) | adminer | http://local.adminer.docker/ | Adminer is a full-featured database management tool written in PHP. |
| [SQLPad](https://rickbergfalk.github.io/sqlpad/) | sqlpad | http://local.sqlpad.docker/ | SQLPad is a self-hosted web app for writing and running SQL queries and visualizing the results. |
| [Redis](https://redis.io/) | redis | - | Redis is an open source (BSD licensed), in-memory data structure store, used as a database, cache and message broker. |
| [Redis Commander](https://joeferner.github.io/redis-commander/) | redis_commander | http://local.redis-commander.docker/ | Redis-Commander is a node.js web application used to view, edit, and manage a Redis Database. |
| [Redis Memtier Benchmark](https://redis.io/topics/benchmarks) | redis-memtier_benchmark | - | Redis includes the redis-benchmark utility that simulates running commands done by N clients at the same time sending M total queries (it is similar to the Apache's ab utility). |
| [ElasticSearch](https://www.elastic.co/fr/products/elasticsearch) | elasticsearch | - | Elasticsearch is a distributed, RESTful search and analytics engine capable of solving a growing number of use cases. |
| [Sense](https://www.elastic.co/guide/en/sense/current/sense-ui.html) | sense | http://local.sense.docker/app/sense/ | Sense is a Kibana app. The editor allows writing multiple requests below each other and running it. |
| [SFTP Server](https://hub.docker.com/r/atmoz/sftp/) | sftp-server | - | SFTP server. |

### Dataflow Stack

| Service | Name | Frontend | Description |
|:--------|:-----|:---------|:------------|
| [RabbitMQ](https://www.rabbitmq.com/) | rabbitmq | http://local.rabbitmq.docker/ | RabbitMQ is an open source message agent software that implements the Advanced Message Queuing protocol, but also with Streaming Text Oriented Messaging Protocol and Message Queuing Telemetry Transport plugins. |
| [Streamsets](https://streamsets.com/) | streamsets | http://local.mailcatcher.docker/ | The StreamSets DataOps Platform simplifies how to build, execute, operate and protect enterprise data movement architectures. |

### Tool Stack

| Service | Name | Frontend | Description |
|:--------|:-----|:---------|:------------|
| [Wireshark](https://www.wireshark.org/) | wireshark | https://local.wireshark.docker:14500/ | Wireshark is a free and open source packet analyzer. |
| [Mailcatcher](https://mailcatcher.me/) | mailcatcher | http://local.mailcatcher.docker/ | MailCatcher runs a super simple SMTP server which catches any message sent to it to display in a web interface. |

## Installation / Setup

- Copy all dist file

	```bash
	cp .env.dist .env
	cp traefik/conf/traefik.toml.dist traefik/conf/traefik.toml
	```
- You have to edit some variable in `.env` file.

- And then run the docker-compose

	```bash
	# Create traefik network if needed
	docker network create traefik
	make build
	make up
	```
- Start and stop services independently (with COMPOSE_PROJECT_NAME variable set to local)

	```bash
	# Build services
	make build services="<service_name> [<service_name>]"
	# Up services
	make up services="<service_name> [<service_name>]"
	# Stop services
	make stop services="local_<service_name> [local_<service_name>]"
	# Down services and remove volumes
	make down services="local_<service_name> [local_<service_name>]"
	```

## Use

### First

You can customize all tools, use the file `docker-compose.override.yml`

- Copy `docker-compose.override.yml.dist` file to `docker-compose.override.yml`

	```shell
	cp docker-compose.override.yml.dist docker-compose.override.yml
	```

Examples :
- Restart some tools at the same time as your system (in my case, traefik & portainer):
	```yaml
	services:
	  traefik:
	    restart: always
	  portainer:
	    restart: always
	```
- Change the Adminer theme

### Documentations

- [Traefik](doc/traefik.md)
- [Devops Stack](doc/devops.md)
- [Storage Stack](doc/storage.md)
- [Dataflow Stack](doc/dataflow.md)
- [Tool Stack](doc/tool.md)
