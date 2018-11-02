# Elastic Stack

## Use

```bash
# Build elastic stack
make build-elastic-stack
# Up elastic stack
make up-elastic-stack
# Stop elastic stack
make stop-elastic-stack
# Down elastic stack and remove volumes
make down-elastic-stack
```

### Logstash

To learn more, I invite you to read [Logstash reference](https://www.elastic.co/guide/en/logstash/current/index.html).

### Logspout

The logspout is used to redirect the logs of each container to the logstash. You will be able to visualize your logs and play with Kibana.

It is also possible to exclude containers from this process. For that you have to modify the `elastic/logstash/pipeline/logstash.conf` file by adding filters, like the following example.

```
filter {
  if [docker][name] =~ /.*container_name.*/ {
    drop { }
  }
  ...
}
```
