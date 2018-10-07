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
