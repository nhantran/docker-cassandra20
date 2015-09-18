# Local Docker Cluster Installation Guide
This is to install a Cassandra cluster in a single host

## Prepare a temporary shared folder for containers
```bash
      if [[ ! -f $HOME/shared ]]; then
          mkdir $HOME/shared
      fi
```

#### Start a single C* container
```bash
      docker run -h cass0 -v $HOME/shared:/opt/shared nhantran/docker-cassandra20
```
#### Start a C* cluster
```bash
      readonly NUM_CONTAINERS=3
      readonly NUM_SEEDS=2

      for i in `seq 1 $NUM_CONTAINERS`; do
         docker run --name cass$i -v $HOME/shared:/opt/shared nhantran/docker-cassandra20 $NUM_CONTAINERS $NUM_SEEDS &
      done
```