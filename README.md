# Devtools

## Dependencies

- [Docker 18.06.1](https://docs.docker.com/install/)
- [Docker Compose 1.22.0 (v3.7)](https://docs.docker.com/compose/)
- [OpenSSL](https://www.openssl.org/)

## Description

Stack of tools for development.

- [Portainer](https://portainer.io/)
- [Traefik](https://traefik.io/)
- [Wireshark](https://www.wireshark.org/)
- [Mysql](https://www.mysql.com/fr/)
- [Adminer](https://www.adminer.org/)
- [SQLPad](https://rickbergfalk.github.io/sqlpad/)
- [ElasticSearch](https://www.elastic.co/fr/products/elasticsearch)
- [Sense](https://www.elastic.co/guide/en/sense/current/sense-ui.html)
- [RabbitMQ](https://www.rabbitmq.com/)
- [Redis](https://redis.io/)
- [Redis Commander](https://joeferner.github.io/redis-commander/)
- [Redis Memtier Benchmark](https://redis.io/topics/benchmarks)
- [Streamsets](https://streamsets.com/)
- [SFTP Server](https://hub.docker.com/r/atmoz/sftp/)
- [Mailcatcher](https://mailcatcher.me/)

## Installation / Setup

- Copy `.env.dist` file to `.env`

```shell
cp .env.dist .env
```

- You have to edit some variable in `.env` file.

- And then run the docker-compose
```shell
# Create traefik network if needed
docker network create traefik
make build
make up
```

- Start and stop services independently 
```shell
# Build service
make build service=<service_name>
# Up service
make up service=<service_name>
# Stop service
make stop service=<service_name>
# Down service and remove volume
make down service=<service_name>
```

## Frontends

Traefik is used as a reverse proxy in order to be able to browse the different web applications. Add them to your favorites in your favorite browser ;)
Here are the different urls to the services (with COMPOSE_PROJECT_NAME variable set to local) :

- http://local.traefik.docker
- http://local.portainer.docker
- http://local.wireshark.docker:14500
- http://local.adminer.docker
- http://local.sqlpad.docker
- http://local.redis-commander.docker
- http://local.sense.docker/app/sense
- http://local.rabbitmq.docker
- http://local.streamsets.docker
- http://local.mailcatcher.docker

## Use

### Docker Compose Override

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
- Add HTTPS to traefik
- Change the Adminer theme

### Traefik

##### General

Traefik is an easy-to-use reverse proxy / load balancer that you can link with your Dockerized projects to have domain names.
To do this, add the following lines to the container:
```yaml
services:
  my_container:
    labels:
      - "traefik.backend=my_container"
      - "traefik.frontend.rule=Host:my_container.${HOST_IP}.xip.io"
      - "traefik.port=8080"
      - "traefik.frontend.passHostHeader=true"
```

##### HTTPS

A self-signed certificate is generated in the container during the first installation, the https is available on all services.

### SFTP Server

To connect to the server, with filezilla for example :

- **host :** sftp://localhost
- **login :** login in env file
- **password :** password in env file
- **port :** port in env file

### Redis - Mass Insertion

A command was specially designed to import data into the redis (container name : redis), to then test the performance of redis with the benchmark mode.
A test file is placed in the data folder, it contains an item that will be multiplied "n" times by the import command.
You can also use your own file, following the template in the file `redis/data/default.txt`.

```shell
# make redis_import_data args="<source_file> <number_multiplier>"
make redis_import_data args="default.txt 500"
```

### Redis - Benchmark mode

Launch benchmark :

```shell
# make redis_memtier_benchmark options="[-h <host>] [-p <port>] [-c <clients>] [-n <requests]> [-k <boolean>]"
make redis_memtier_benchmark options="-n 1000"
```

### Adminer - Themes

The image bundles all the designs that are available in the source package of adminer. 
You can find the [list of designs](https://github.com/vrana/adminer/tree/master/designs) on GitHub.

To change theme, just add the following entry in your `docker-compose.override.yml` file and change the value of ADMINER_DESIGN variable.

```yaml
  adminer:
    environment:
      - ADMINER_DESIGN=rmsoft
```
