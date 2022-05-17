#! /bin/bash
#set -x

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
export captainAddr="0xbbE4733d85bc2b90682147779DA49caB38C0aA1F"

export fromBlockNum=$(curl -X POST $rpc_url -s -H 'Content-Type: application/json' -d '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":1}' | jq '.result')
export fromBlockHash=$(curl -X POST $rpc_url -s -H 'Content-Type: application/json' -d "{\"jsonrpc\":\"2.0\",\"method\":\"eth_getBlockByNumber\",\"params\":[$fromBlockNum,false],\"id\":1}" | jq '.result|.hash')

#unlock
curl -X POST $rpc_url -s -H 'Content-Type: application/json' -d '{"jsonrpc":"2.0","method":"personal_unlockAccount","params":["0xbbE4733d85bc2b90682147779DA49caB38C0aA1F", "", 30],"id":1}'

#nonce = 1
export txContractDeployHash=$(curl -X POST $rpc_url -s -H 'Content-Type: application/json' -d '{"jsonrpc":"2.0","method":"eth_sendRawTransaction","params":["0xf90802018405f5e100830abd028080b907af608060405234801561001057600080fd5b5061078f806100206000396000f3fe608060405234801561001057600080fd5b50600436106100575760003560e01c80632867e37a1461005c5780632e64cec1146100785780634b7e0c70146100965780636057361d146100b2578063c03c3003146100ce575b600080fd5b61007660048036038101906100719190610312565b6100ea565b005b610080610158565b60405161008d9190610401565b60405180910390f35b6100b060048036038101906100ab919061036e565b610161565b005b6100cc60048036038101906100c7919061039b565b6101c8565b005b6100e860048036038101906100e3919061036e565b6101e3565b005b60005b825181101561013b57828181518110610109576101086106a8565b5b60200260200101516000808282546101219190610501565b92505081905550808061013390610630565b9150506100ed565b508060008082825461014d9190610501565b925050819055505050565b60008054905090565b8060015461016f9190610557565b6001819055503373ffffffffffffffffffffffffffffffffffffffff167fa9e1ad4b2e8143c00f604064418267d97690c4325d3506b2daf7443fd3ab8e8a6001546040516101bd91906103e6565b60405180910390a250565b806000808282546101d99190610501565b9250508190555050565b806001546101f1919061046d565b6001819055503373ffffffffffffffffffffffffffffffffffffffff167f5b896ba66c89a01c6105a12eaf566e422dbdc1f8bbe5e4d96b6095249bc09c0a60015460405161023f91906103e6565b60405180910390a250565b600061025d61025884610441565b61041c565b905080838252602082019050828560208602820111156102805761027f61070b565b5b60005b858110156102b0578161029688826102fd565b845260208401935060208301925050600181019050610283565b5050509392505050565b600082601f8301126102cf576102ce610706565b5b81356102df84826020860161024a565b91505092915050565b6000813590506102f78161072b565b92915050565b60008135905061030c81610742565b92915050565b6000806040838503121561032957610328610715565b5b600083013567ffffffffffffffff81111561034757610346610710565b5b610353858286016102ba565b9250506020610364858286016102fd565b9150509250929050565b60006020828403121561038457610383610715565b5b6000610392848285016102e8565b91505092915050565b6000602082840312156103b1576103b0610715565b5b60006103bf848285016102fd565b91505092915050565b6103d1816105eb565b82525050565b6103e0816105f5565b82525050565b60006020820190506103fb60008301846103c8565b92915050565b600060208201905061041660008301846103d7565b92915050565b6000610426610437565b905061043282826105ff565b919050565b6000604051905090565b600067ffffffffffffffff82111561045c5761045b6106d7565b5b602082029050602081019050919050565b6000610478826105eb565b9150610483836105eb565b9250817f7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff038313600083121516156104be576104bd610679565b5b817f80000000000000000000000000000000000000000000000000000000000000000383126000831216156104f6576104f5610679565b5b828201905092915050565b600061050c826105f5565b9150610517836105f5565b9250827fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0382111561054c5761054b610679565b5b828201905092915050565b6000610562826105eb565b915061056d836105eb565b9250827f8000000000000000000000000000000000000000000000000000000000000000018212600084121516156105a8576105a7610679565b5b827f7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0182136000841216156105e0576105df610679565b5b828203905092915050565b6000819050919050565b6000819050919050565b6106088261071a565b810181811067ffffffffffffffff82111715610627576106266106d7565b5b80604052505050565b600061063b826105f5565b91507fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff82141561066e5761066d610679565b5b600182019050919050565b7f4e487b7100000000000000000000000000000000000000000000000000000000600052601160045260246000fd5b7f4e487b7100000000000000000000000000000000000000000000000000000000600052603260045260246000fd5b7f4e487b7100000000000000000000000000000000000000000000000000000000600052604160045260246000fd5b600080fd5b600080fd5b600080fd5b600080fd5b6000601f19601f8301169050919050565b610734816105eb565b811461073f57600080fd5b50565b61074b816105f5565b811461075657600080fd5b5056fea2646970667358221220297e998324ed9c867356c2d61fd1803a71d61fbae9bccb4dbcab6a4064da9f9164736f6c6343000807003381e9a0e571021d9be2e893ab66fa36e2a80cbeb247607784910ce8085f03c300193053a027961e5c4240ac058d68b09870ad83bb9c963f70ddc47e7b352ae342230366d2"],"id":1}' | jq '.result')
#nonce = 2
export txHash=$(curl -X POST $rpc_url -s -H 'Content-Type: application/json' -d '{"jsonrpc":"2.0","method":"eth_sendTransaction","params":[{"from":"0xbbE4733d85bc2b90682147779DA49caB38C0aA1F", "to":"0x2727D250a14aa69FdcD702C82b314717aBa4A6d0", "value":"0x16345785d8a0000", "gas":"0x52080", "gasPrice":"0x55ae82600"}],"id":1}' | jq '.result')

sleep 4
txRes=$(curl -X POST $rpc_url -s -H 'Content-Type: application/json' -d "{\"jsonrpc\":\"2.0\",\"method\":\"eth_getTransactionByHash\",\"params\":[$txHash],\"id\":1}" | jq '.result')
export txBlockHash=$(echo $txRes | jq '.blockHash')
export txBlockNum=$(echo $txRes | jq '.blockNumber')

txContractDeployRes=$(curl -X POST $rpc_url -s -H 'Content-Type: application/json' -d "{\"jsonrpc\":\"2.0\",\"method\":\"eth_getTransactionByHash\",\"params\":[$txContractDeployHash],\"id\":1}" | jq '.result')
export txContractDeployBlockHash=$(echo $txContractDeployRes | jq '.blockHash')
export txContractDeployBlockNum=$(echo $txContractDeployRes | jq '.blockNumber')
txContractReceipt=$(curl -X POST $rpc_url -s -H 'Content-Type: application/json' -d "{\"jsonrpc\":\"2.0\",\"method\":\"eth_getTransactionReceipt\",\"params\":[$txContractDeployHash],\"id\":1}" | jq '.result')
export contractAddr=$(echo $txContractReceipt | jq '.contractAddress')

#nonce = 3
export txContractStoreHash=$(curl -X POST $rpc_url -s -H 'Content-Type: application/json' -d "{\"jsonrpc\":\"2.0\",\"method\":\"eth_sendTransaction\",\"params\":[{\"from\":\"0xbbE4733d85bc2b90682147779DA49caB38C0aA1F\",\"to\":$contractAddr,\"input\":\"0xc03c30030000000000000000000000000000000000000000000000000000000000000001\"}],\"id\":1}" | jq '.result')

sleep 4
txContractStoreRes=$(curl -X POST $rpc_url -s -H 'Content-Type: application/json' -d "{\"jsonrpc\":\"2.0\",\"method\":\"eth_getTransactionByHash\",\"params\":[$txContractStoreHash],\"id\":1}" | jq '.result')
export txContractStoreBlockHash=$(echo $txContractStoreRes | jq '.blockHash')
export txContractStoreBlockNum=$(echo $txContractStoreRes | jq '.blockNumber')

txContractStoreReceipt=$(curl -X POST $rpc_url -s -H 'Content-Type: application/json' -d "{\"jsonrpc\":\"2.0\",\"method\":\"eth_getTransactionReceipt\",\"params\":[$txContractStoreHash],\"id\":1}" | jq '.result')
export topic=$(echo $txContractStoreReceipt | jq '.logs|.[0]|.topics|.[0]')

sleep 4
export toBlockNum=$(curl -X POST $rpc_url -s -H 'Content-Type: application/json' -d '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":1}' | jq '.result')
export toBlockHash=$(curl -X POST $rpc_url -s -H 'Content-Type: application/json' -d "{\"jsonrpc\":\"2.0\",\"method\":\"eth_getBlockByNumber\",\"params\":[$toBlockNum,false],\"id\":1}" | jq '.result|.hash')