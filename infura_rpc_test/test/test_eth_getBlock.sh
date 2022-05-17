#! /bin/bash

run_test_Block(){
    data=$1
    onErr=$2
    errCode=$3

    rpc=$(getResponse $rpc_url $data)
    infura=$(getResponse $infura_url $data)

    if [ "$onErr" == "require_err" ]
    then
        require_err "$rpc" "$infura" "$errCode"
    elif [ "$onErr" == "require_null" ]
    then
        require_null "$rpc" "$infura" 
    else
        compare_block_result "$rpc" "$infura"
    fi
}

compare_block_result(){
    rpc=$1
    infura=$2

    rpc_res=$(echo $rpc | jq '.result')
    rpc_err=$(echo $rpc | jq '.error|.message')

    infura_res=$(echo $infura | jq '.result')
    infura_err=$(echo $infura | jq '.error|.message')

    if [ "$rpc_err" != null ] 
    then
        echo "rpc_error_$rpc_err" | tr ' ' '_'
        return 1
    fi
    if [ "$infura_err" != null ] 
    then
        echo "infura_error_$infura_err" | tr ' ' '_'
        return 1
    fi
    if [ "$rpc_res" == null ] || [ "$rpc_res" == "" ]
    then
        echo "rpc_response_is_null"
        return 1
    fi
    if [ "$infura_res" == null ] || [ "$infura_res" == "" ]
    then
        echo "infura_response_is_null"
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
    data="{\"jsonrpc\":\"2.0\",\"method\":\"eth_getBlockByNumber\",\"params\":[$txBlockNum,false],\"id\":1}"
    run_test_Block $data
}

test_eth_getBlockByHash(){
    #eth_getLogs
    data="{\"jsonrpc\":\"2.0\",\"method\":\"eth_getBlockByHash\",\"params\":[$txBlockHash,false],\"id\":1}"
    run_test_Block $data
}

test_eth_getBlockByHash_fulltx(){
    #eth_getLogs
    data="{\"jsonrpc\":\"2.0\",\"method\":\"eth_getBlockByHash\",\"params\":[$txBlockHash,true],\"id\":1}"
    run_test_Block $data
}

test_eth_getBlockByHash_errBlockHash(){
    #eth_getLogs
    data="{\"jsonrpc\":\"2.0\",\"method\":\"eth_getBlockByHash\",\"params\":[\"0xfffffffffffdb68150f1cc8e416d9a712d1b114daa02eeab5ff6f69321b1b08c\",false],\"id\":1}"
    run_test_Block $data "require_err"
}