# Proxy

## Traefik
### Use

Traefik is an easy-to-use reverse proxy / load balancer that you can link with your Dockerized projects to have domain names.
To do this, add the following lines to the container:
```yaml
services:
  my_container:
    labels:
      - "traefik.backend=my_container"
      - "traefik.frontend.rule=Host:my_container.traefik.docker"
      - "traefik.port=8080"
```

### Be aware, linux users

Generally linux distributions always have a dns resolver (for ubuntu distributions, there is a dnsmasq service that handles the resolution for example), so there are some things to do before running traefik:
* Add the following line to your `/etc/NetworkManager/dnsmasq.d/dnsmasq.conf` file.
```
# /etc/NetworkManager/dnsmasq.d/dnsmasq.conf
address=/.docker/127.0.0.1
```
* Restart the network manager service : `sudo service network-manager restart`

### HTTPS

A self-signed certificate is generated in the container during the first installation, the https is available on all services.

### Go even further !

It's possible to use its own certificate, for that it is necessary to place the files in the corresponding folders:
* `proxy/traefik/ssl/ca`
* `proxy/traefik/ssl/certs`
* `proxy/traefik/ssl/private`

In this way you will be able to use a certificate signed by your own authority.  

**Help :** [Generate an authority and certificates signed by it](https://jamielinux.com/docs/openssl-certificate-authority/index.html)
