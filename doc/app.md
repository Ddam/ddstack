# App Stack

## Use

```bash
# Build app stack
make build-app-stack
# Up app stack
make up-app-stack
# Stop app stack
make stop-app-stack
# Down app stack and remove volumes
make down-app-stack
```

## Symfony

Big thanks to [Kévin Dunglas](https://github.com/dunglas) and your [Symfony Docker repository](https://github.com/dunglas/symfony-docker).
Taking example of its repository and with help of [Thomas Talbot](https://github.com/Ioni14), I set up a Symfony app thanks to Docker's [multi-stage build](https://docs.docker.com/develop/develop-images/multistage-build/).

### Dependencies

- [symfony >= 4](https://symfony.com/doc/current/setup.html)
- [dotenv](https://symfony.com/doc/current/components/dotenv.html)
- [monolog](https://symfony.com/doc/current/logging.html)
- [twig](https://symfony.com/doc/current/templating.html)
- [encore](https://symfony.com/doc/current/frontend.html)
- [profiler](https://symfony.com/doc/current/profiler.html)

### Use

```bash
# Build sf stack
make build-sf-stack
# Up sf stack
make up-sf-stack
# Stop sf stack
make stop-sf-stack
# Down sf stack and remove volumes
make down-sf-stack
```

### First

To begin, you need to install a version of Symfony 4, a make command was created for this purpose.
```bash
# Warning, this command deletes entire app/symfony folder each time
make sf-install
```
The Symfony version installed is the one set in `SYMFONY_VERSION` environment variable.

Check in `app/symfony` folder, if all the files have been created. If so, the following commands to launch the application.
```bash
cp app/symfony/.env.dist app/symfony/.env
make build-sf-stack
make up-sf-stack
```

Et voilà, your application is accessible in HTTP/HTTPS at: https://sf-app.traefik.docker

### Developpment mode

For development version we will use a PHP container a little more evolved, with [Xdebug](https://xdebug.org/) and [Composer](https://getcomposer.org/) previously installed.
In addition, to avoid having to restart the containers with each code change, we will use the Docker volumes.

We can go development mode thanks to [override](https://docs.docker.com/compose/reference/overview/#specifying-multiple-compose-files) of Docker Compose. 
In your `docker-compose.override.yml` file, uncomment following lines:

```yaml
services:
  sf_php:
    build:
      context: app/symfony
      target: build_php_dev
      dockerfile: docker/Dockerfile
    volumes:
      - ./app/symfony:/app
    environment:
      # Docker for mac : try remote_host=host.docker.internal instead of remote_connect_back
      XDEBUG_CONFIG: >-
        remote_enable=1
        remote_connect_back=1
        remote_port=9001
        idekey=PHPSTORM
  
  sf_apache:
    volumes:
      - ./app/symfony/public:/app/public
```

Et voilà, your developpement application (with web profiler and Xdebug) is accessible at: https://sf-app.traefik.docker

If you use PHPStorm, here's how to [configure Xdebug](https://www.jetbrains.com/help/phpstorm/configuring-xdebug.html).
