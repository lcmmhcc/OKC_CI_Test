#! /bin/bash

run_test_Block(){
    data=$1
    rpc=$(getResponse $rpc_url $data)
    rpc_res=$(echo $rpc | jq '.result')
    rpc_err=$(echo $rpc | jq '.error')
    
    #echo $rpc_res
    infura=$(getResponse $rpc_url $data | jq '.result')
    infura_res=$(echo $infura | jq '.result')
    infura_err=$(echo $infura | jq '.error')
    #echo $infura_res
    
    if [ ! -n $rpc_err ] 
    then
        $rpc_err_msg=$(echo $rpc_err | jq '.message')
        echo "rpc_error_$rpc_err_msg" | tr ' ' '_'
        return 1
    fi
    if [ ! -n $infura_err ] 
    then
        $infura_err_msg=$(echo $infura_err | jq '.message')
        echo "infura_error_$infura_err_msg" | tr ' ' '_'
        return 1
    fi
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

test_eth_getBlockByNumber(){
    #eth_getLogs
    data='{"jsonrpc":"2.0","method":"eth_getBlockByNumber","params":["0x1",false],"id":1}'
    run_test_Block $data
}

test_eth_getBlockByHash(){
    #eth_getLogs
    data="{\"jsonrpc\":\"2.0\",\"method\":\"eth_getBlockByNumber\",\"params\":[\"0xa84fc124c4209782fa5598b07daf70a1805241fb9a0e3635d13fa49fd74ca01c\",false],\"id\":1}"
    run_test_Block $data
}

test_eth_getBlockByHash_fulltx(){
    #eth_getLogs
    data='{"jsonrpc":"2.0","method":"eth_getBlockByNumber","params":["0xa84fc124c4209782fa5598b07daf70a1805241fb9a0e3635d13fa49fd74ca01c",true],"id":1}'
    run_test_Block $data
}
