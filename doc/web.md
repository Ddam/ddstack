# Web Stack

## Use

```bash
# Build web stack
make build-web-stack
# Up web stack
make up-web-stack
# Stop web stack
make stop-web-stack
# Down web stack and remove volumes
make down-web-stack
```

### SSL mode & autosigned cert

It is possible to activate the SSL mode of Apache, for that, modify HTTPD_SSL_MODE environment variable to 1. If you already have a certificate, place files in intended place, `web/apache/ssl/`.
If not, modify HTTPD_AUTOSIGNED_CERT environment variable to 1 to generate a self-signed certificate when the container starts.

### FPM Handler mode

Pour activer le mode FPM, il suffit de modifier la variable d'environnement HTTPD_PHP_FPM_HANDLER à 1. Attention, pour faire fonctionner le mode FPM il faut avoir un conteneur PHP en parallèle. 
De plus, le conteneur PHP doit être placé sur le même réseau que celui d'Apache avec pour alias la valeur de la variable d'environnement HTTPD_PHP_FPM_HANDLER.

To activate the FPM mode, simply change HTTPD_PHP_FPM_HANDLER environment variable to 1. Warning, to operate the FPM mode you must have a PHP container in parallel.
In addition, PHP container must be placed on the same network as Apache with an alias, the value of the HTTPD_PHP_FPM_HANDLER environment variable.

Example :
```yaml
services:
  php:
    networks:
      traefik:
        aliases:
          - ${HTTPD_PHP_FPM_HANDLER}
```
