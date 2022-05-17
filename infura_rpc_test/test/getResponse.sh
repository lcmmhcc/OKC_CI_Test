#! /bin/bash

export infura_url="http://127.0.0.1:8080"
export rpc_url="http://127.0.0.1:8545"

getResponse(){
    url=$1
    content=$2
    resp=$(curl -X POST $url -H "Content-Type: application/json" -d "$content")
    echo "$resp"
}
export -f getResponse
