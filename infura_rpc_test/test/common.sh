#! /bin/bash

getResponse(){
    url=$1
    content=$2
    resp=$(curl -X POST $url -H "Content-Type: application/json" -d "$content" -s)
    echo "$resp"
}

require_err(){
    rpc=$1
    infura=$2
    errCode=$3

    rpc_err_code=$(echo $rpc | jq '.error|.code')
    infura_err_code=$(echo $infura | jq '.error|.code')

    if [ "$rpc_err_code" == null ] || [ -z "$rpc_err_code" ] || [ -n "$rpc_err_code" ]
    then
        echo "rpc_err_is_null"
        return 1
    fi
    if [ "$infura_err_code" == null ] || [ -z "$infura_err_code" ] || [ -n "$infura_err_code" ]
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