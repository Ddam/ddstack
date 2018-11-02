# Devops Stack

## Use

```bash
# Build devops stack
make build-devops-stack
# Up devops stack
make up-devops-stack
# Stop devops stack
make stop-devops-stack
# Down devops stack and remove volumes
make down-devops-stack
```

## Jenkins

The Jenkins provided here is specially configured to run PHP Docker jobs. However it is also possible to configure it for another stack, by installing necessary plugins.

### Plugins

The list of installed plugins can be found in the file `jenkins/ref/plugin.txt`, they are needed for PHP Docker builds.
You can also use your own plugins, by placing list of plugin ids you want to install.
You can configure them by adding the corresponding `.groovy` file in the` jenkins/ref/init.groovy.d` folder (following the template in other files).

## Portainer

### Automatic admin user creation

Use the following command to generate a hash for the password:
```bash
docker run --rm httpd:2.4-alpine htpasswd -nbB admin 'superpassword' | cut -d ":" -f 2
```
The output of that command is the hashed password, it should be something similar to $2y$05$w5wsvlEDXxPjh2GGfkoe9.At0zj8r7DeafAkXXeubs0JnmxLjyw/a.

You need to escape each $ character inside the hashed password with another $:
```
$$2y$$05$$ZBq/6oanDzs3iwkhQCxF2uKoJsGXA0SI4jdu1PkFrnsKfpCH5Ae4G
```
Finally, in your `.env`, set `PORTAINER_PASSWORD` variable with this value.

