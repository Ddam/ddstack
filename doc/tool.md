# Tool Stack

## Use

```bash
# Build tool stack
make build-tool-stack
# Up tool stack
make up-tool-stack
# Stop tool stack
make stop-tool-stack
# Down tool stack and remove volumes
make down-tool-stack
```

### Redis - Benchmark mode

Launch benchmark :

```bash
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
