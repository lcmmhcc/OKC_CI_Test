#! /bin/bash

# docker pull mysql/mysql-server
# docker pull redis

# docker run --name mysql -p 3306:3306 -v ~/infura_rpc_test/data/:/var/lib/mysql -e okt1000AAA -d mysql/mysql-server
# docker run --name redis -p 6379:6379 -d redis --requirepass okt888AAA



# docker exec -it mysql /bin/bash
# echo "skip-grant-tables" >> /etc/my.cnf

# docker restart mysql

# mysql -uroot -pokt1000AAA


# ./infura-service start --address :26659 --mysql-url=127.0.0.1:3306 --mysql-user=root --mysql-pass=okt1000AAA --redis-auth=okt888AAA

export infura_url="http://127.0.0.1:26659"
export rpc_url="http://127.0.0.1:8545"

export fromBlockNum=$(curl -X POST $rpc_url -s -H 'Content-Type: application/json' -d '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":1}' | jq '.result')
export fromBlockHash=$(curl -X POST $rpc_url -s -H 'Content-Type: application/json' -d "{\"jsonrpc\":\"2.0\",\"method\":\"eth_getBlockByNumber\",\"params\":[$fromBlockNum,false],\"id\":1}" | jq '.result|.hash')

#send tx
curl -X POST http://127.0.0.1:8545 -H 'Content-Type: application/json' -d '{"jsonrpc":"2.0","method":"personal_unlockAccount","params":["0xbbE4733d85bc2b90682147779DA49caB38C0aA1F", "", 30],"id":1}'
export txHash=$(curl -X POST http://127.0.0.1:8545 -H 'Content-Type: application/json' -d '{"jsonrpc":"2.0","method":"eth_sendTransaction","params":[{"from":"0xbbE4733d85bc2b90682147779DA49caB38C0aA1F", "to":"0x2727D250a14aa69FdcD702C82b314717aBa4A6d0", "value":"0x16345785d8a0000", "gas":"0x52080", "gasPrice":"0x55ae82600"}],"id":1}' | jq '.result')
txRes=$(curl -X POST http://127.0.0.1:8545 -H 'Content-Type: application/json' -d "{\"jsonrpc\":\"2.0\",\"method\":\"eth_getTransactionByHash\",\"params\":[$txHash],\"id\":1}" | jq '.result')
export txBlockHash=$(echo $txRes | jq '.blockHash')
export txBlockNum=$(echo $txRes | jq '.blockNumber')

sleep 5
export toBlockNum=$(curl -X POST $rpc_url -s -H 'Content-Type: application/json' -d '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":1}' | jq '.result')
export toBlockHash=$(curl -X POST $rpc_url -s -H 'Content-Type: application/json' -d "{\"jsonrpc\":\"2.0\",\"method\":\"eth_getBlockByNumber\",\"params\":[$toBlockNum,false],\"id\":1}" | jq '.result|.hash')

