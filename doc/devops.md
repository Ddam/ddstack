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

## Ansistrano

### Dependencies

- [openssh-client](https://www.openssh.com/) : `sudo apt install openssh-client`
- [openssh-server](https://www.openssh.com/) : `sudo apt install openssh-server`

### Use

- Setting up `ANSISTRANO_WEBSERVERS` environnement variable with hosts production, preproduction, test, etc.
  ```
  ANSISTRANO_WEBSERVERS=pass:user@host,pass1:user1@host1
  ```

- Also add these hosts to global `devops/ansistrano/conf/hosts` file.
  ```
  [webservers]
  10.25.1.56 ansible_user=user
  10.25.1.57 ansible_user=user
  ```

- Configure Ansible through `devops/ansistrano/conf/ansible.cfg` file and start container.
  ```bash
  make build services="ansistrano"
  make up services="ansistrano"
  ```

You can check on Portainer that the container's status is "healthy", which means that Ansible successfully ping all hosts.

### Playbook - Deploy

A Symfony rsync playbook is provided (`devops/ansistrano/playbooks/symfony`), it allows the Symfony 4 application (`app/symfony`) to be deployed to a remote server or directly to local machine.

The only prerequisite for using this playbook is filling the `devops/ansistrano/playbooks/symfony/hosts.ini` file with prod and preprod hosts.
```
[webservers]
10.25.1.56 ansible_user=user
10.25.1.57 ansible_user=user
```

### Local

- First, you have to install openssh-client, openssh-server and authorize a ssh root connection.
  ```bash
  sudo apt update
  sudo apt install openssh-client
  sudo apt install openssh-server
  # Add a root password, and enter password
  sudo passwd
  # Changes PermitRootLogin in /etc/ssh/sshd_config
  # Change by PermitRootLogin yes
  sudo vim /etc/ssh/sshd_config
  ```

- Add to `ANSISTRANO_WEBSERVERS` environnement variable your local machine. To recover your local IP address on Linux, run following command.
  ```bash
  ip a show `ip route show default|awk '/default/ {print $5}'`|sed -En 's/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'
  ```

- Setting up `ANSISTRANO_WEBSERVERS` environnement variable with path on your machine where you want to deploy

- Finally, link ansitrano with your local machine and run container.
  ```bash
  make ansistrano-local-link
  make up services="ansistrano"
  ```

### Deploy

A deployment command has been created, it allows to launch a deployment following the desired playbook Ansible.
```bash
make ansistrano-deploy playbook="symfony"
```

### Create your own playbook

The Symfony playbook is relatively simple and especially present for example.
It is possible to create its own configuration by placing it in a new folder at root (`devops/ansistrano/playbooks`)

To deploy according to your playbook, simply indicate its name to the deployment command.
```bash
make ansistrano-deploy playbook="custom-playbook"
```
