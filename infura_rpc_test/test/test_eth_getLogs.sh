#! /bin/bash
set +e

run_test_logs(){
    data=$1
    onErr=$2

    rpc=$(getResponse $rpc_url $data)
    infura=$(getResponse $infura_url $data)

    if [ "$onErr" == "require_err" ]
    then
        require_err "$rpc" "$infura" 
    elif [ "$onErr" == "require_null" ]
    then
        require_null "$rpc" "$infura" 
    else
        compare_logs "$rpc" "$infura"
    fi
}
compare_logs(){
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

    rpc_res_tx_hash=$(echo $rpc_res | jq '.transactionHash')
    infura_res_tx_hash=$(echo $infura_res | jq '.transactionHash')

    if [ $rpc_res_tx_hash != $infura_res_tx_hash ]
    then
        echo "response_tx_hash_is_not_equal"
        return 1
    fi

    rpc_res_tx_block_hash=$(echo $rpc_res | jq '.blockHash')
    infura_res_tx_block_hash=$(echo $infura_res | jq '.blockHash')

    if [ $rpc_res_tx_block_hash != $infura_res_tx_block_hash ]
    then
        echo "response_tx_block_hash_is_not_equal"
        return 1
    fi

    rpc_res_tx_block_Num=$(echo $rpc_res | jq '.blockNumber')
    infura_res_tx_block_Num=$(echo $infura_res | jq '.blockNumber')

    if [ $rpc_res_tx_block_Num != $infura_res_tx_block_Num ]
    then
        echo "response_tx_block_Num_is_not_equal"
        return 1
    fi

    rpc_res_tx_address=$(echo $rpc_res | jq '.address')
    infura_res_tx_address=$(echo $infura_res | jq '.address')

    if [ $rpc_res_tx_address != $infura_res_tx_address ]
    then
        echo "response_tx_address_is_not_equal"
        return 1
    fi

    echo "success"
    return 0
}

test_eth_getLogs_byBlockHash(){
    #eth_getLogs
    data="{\"method\":\"eth_getLogs\",\"params\":[{\"blockhash\": $txContractStoreBlockHash}],\"id\":1,\"jsonrpc\":\"2.0\"}"
    run_test_logs $data
    return $?
}

test_eth_getLogs_byAddress(){
    #eth_getLogs
    data="{\"method\":\"eth_getLogs\",\"params\":[{\"address\":$contractAddr}],\"id\":1,\"jsonrpc\":\"2.0\"}"
    run_test_logs $data
    return $?
}

test_eth_getLogs_byFromTo(){
    #eth_getLogs
    data="{\"method\":\"eth_getLogs\",\"params\":[{\"fromBlock\": $fromBlockNum,\"toBlock\": $toBlockNum}],\"id\":1,\"jsonrpc\":\"2.0\"}"
    run_test_logs $data
    return $?
}

test_eth_getLogs_byTopic(){
    #eth_getLogs
    data="{\"method\":\"eth_getLogs\",\"params\":[{\"topic\":$topic}],\"id\":1,\"jsonrpc\":\"2.0\"}"
    run_test_logs $data
    return $?
}

