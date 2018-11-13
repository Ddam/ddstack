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
