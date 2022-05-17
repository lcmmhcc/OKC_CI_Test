#! /bin/bash

run_test_txRecp(){
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

test_eth_getTransactionReceipt(){
    #eth_getLogs
    data='{"jsonrpc":"2.0","method":"eth_getTransactionReceipt","params":["0x09929d9c2fdfacc65ba9ee658b04851eb6f4474a33ff95b6d7421ca008f1d22b"],"id":1}'
    run_test_txRecp $data
}