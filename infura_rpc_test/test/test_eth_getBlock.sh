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

    rpc_res_block_num=$(echo $rpc_res | jq '.number')
    infura_res_block_num=$(echo $rpc_res | jq '.number')

    if [ $rpc_res_block_num != $infura_res_block_num ]
    then
        echo "response_block_num_is_not_equal"
        return 1
    fi

    rpc_res_block_hash=$(echo $rpc_res | jq '.hash')
    infura_res_block_hash=$(echo $rpc_res | jq '.hash')

    if [ $rpc_res_block_hash != $infura_res_block_hash ]
    then
        echo "response_block_hash_is_not_equal"
        return 1
    fi

    echo "success"
    return 0
}

test_eth_getBlockByNumber(){
    #eth_getLogs
    data='{"jsonrpc":"2.0","method":"eth_getBlockByNumber","params":["0x1",false],"id":1}'
    run_test_Block $data
}

test_eth_getBlockByHash(){
    #eth_getLogs
    data="{\"jsonrpc\":\"2.0\",\"method\":\"eth_getBlockByNumber\",\"params\":[$fromBlockHash,false],\"id\":1}"
    run_test_Block $data
}

test_eth_getBlockByHash_fulltx(){
    #eth_getLogs
    data="{\"jsonrpc\":\"2.0\",\"method\":\"eth_getBlockByNumber\",\"params\":[$fromBlockHash,true],\"id\":1}"
    run_test_Block $data
}
