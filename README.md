# data-store

## Running Locally

### Initial Setup

1. Install Docker Desktop
2. Create mid-network for hyperledger and services: 
3. `docker network create --subnet 192.168.32.0/24 mid-network`

### To Reset Hyperledger Besu Chain
1. Run  `./reset_besu.sh`
2. Follow `Initial Setup`

### To Launch

* `docker-compose pull`
* `docker-compose up -d`


### To Launch on ARM64

1. Create a .env file in the base directory
2. Add the following line:
```
COMPOSE_FILE=docker-compose.yaml:docker-compose-arm64.yaml
```