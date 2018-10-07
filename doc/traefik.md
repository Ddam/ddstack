# Traefik

## Use

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

## HTTPS

A self-signed certificate is generated in the container during the first installation, the https is available on all services.
