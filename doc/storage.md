# Storage Stack

## Use

```bash
# Build storage stack
make build-storage-stack
# Up storage stack
make up-storage-stack
# Stop storage stack
make stop-storage-stack
# Down storage stack and remove volumes
make down-storage-stack
```

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

```bash
# make redis_import_data args="<source_file> <number_multiplier>"
make redis_import_data args="default.txt 500"
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
