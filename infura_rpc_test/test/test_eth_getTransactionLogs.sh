#! /bin/bash
set +e

run_test_txlogs(){
    data=$1
    rpc_res=$(getResponse $rpc_url $data | jq '.result')
    #echo $rpc_res
    infura_res=$(getResponse $rpc_url $data | jq '.result')
    #echo $infura_res
    
    if [ -z "$rpc_res" ]
    then
        echo "rpc_response_is_nil"
        return 1
    fi
    if [ -z "$infura_res" ]
    then
        echo "infura_response_is_nil"
        return 1
    fi

    if [ $rpc_res == $infura_res ]
    then
        echo "success"
        return 0
    else
        echo "rpc_response_is_not_equal_to_infura"
        return 1
    fi
}

test_eth_getTransactionLogs(){
    #eth_getLogs
    data='{"jsonrpc":"2.0","method":"eth_getTransactionLogs","params":["0x62c2c7f84f2f7c99406a7a17c2831496c4c3d0c50f4d8285373c960d0811252b"],"id":1}'
    run_test_txlogs $data
}
