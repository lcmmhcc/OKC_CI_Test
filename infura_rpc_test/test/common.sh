#! /bin/bash

getResponse(){
    url=$1
    content=$2
    resp=$(curl -X POST $url -H "Content-Type: application/json" -d "$content" -s)
    echo "$resp"
}
require_null(){
    rpc=$1
    infura=$2

    rpc_res=$(echo $rpc | jq '.error|.result')
    infura_res=$(echo $infura | jq '.error|.result')

    if [ "$rpc_res" != null ]
    then
        echo "rpc_response_is_not_null"
        return 1
    fi
    if [ "$infura_res" != null ]
    then
        echo "infura_response_is_not_null"
        return 1
    fi
    echo "success"
    return 0 
}
require_err(){
    rpc=$1
    infura=$2
    errCode=$3

    rpc_err_code=$(echo $rpc | jq '.error|.code')
    infura_err_code=$(echo $infura | jq '.error|.code')

    if [ "$rpc_err_code" == null ] || [ "$rpc_err_code" == "" ] 
    then
        echo "rpc_err_is_null"
        return 1
    fi
    if [ "$infura_err_code" == null ] || [ "$infura_err_code" == "" ]
    then
        echo "infura_err_is_null"
        return 1
    fi
    if [ "$rpc_err_code" != "$infura_err_code" ]
    then
        echo "err_is_not_equal"
        return 1
    fi
    echo "success"
    return 0
}