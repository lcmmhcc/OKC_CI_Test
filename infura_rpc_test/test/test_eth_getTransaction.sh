#! /bin/bash
run_test_tx(){
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

test_eth_getTransactionbyBlockNumberAndIndex(){
    #eth_getLogs
    data='{"jsonrpc":"2.0","method":"eth_getTransactionByBlockNumberAndIndex","params": ["0xe","0x0"],"id":1}' 
    run_test_tx $data
}

test_eth_getTransactionbyBlockHashAndIndex(){
    #eth_getLogs
    data='{"jsonrpc":"2.0","method":"eth_getTransactionByBlockHashAndIndex","params": ["0xa84fc124c4209782fa5598b07daf70a1805241fb9a0e3635d13fa49fd74ca01c","0x1"],"id":1}' 
    run_test_tx $data
}

