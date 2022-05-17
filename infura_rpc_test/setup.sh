#! /bin/bash

docker pull mysql/mysql-server
docker pull redis

docker run --name mysql -p 3306:3306 -v ~/infura_rpc_test/data/:/var/lib/mysql -e okt1000AAA -d mysql/mysql-server
docker run --name redis -p 6379:6379 -d redis --requirepass okt888AAA



docker exec -it mysql /bin/bash
echo "skip-grant-tables" >> /etc/my.cnf

docker restart mysql

mysql -uroot -pokt1000AAA


./infura-service start --address :26659 --mysql-url=127.0.0.1:3306 --mysql-user=root --mysql-pass=okt1000AAA --redis-auth=okt888AAA


fromBlock=$(curl -X POST http://127.0.0.1:8545 -H 'Content-Type: application/json' -d '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":1}' | jq '.result')

#send tx
#get tx
#get block


toBlock=$(curl -X POST http://127.0.0.1:8545 -H 'Content-Type: application/json' -d '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":1}' | jq '.result')
