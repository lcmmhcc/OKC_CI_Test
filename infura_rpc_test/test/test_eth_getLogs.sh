#! /bin/bash
set +e

run_test_logs(){
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
    rpc_number=$(echo $rpc_res | jq '.number')
    infura_number=$(echo $infura_res | jq '.number')

    if [ $rpc_number != $infura_res ]
    then
        echo "response_number_not_equal"
        return 1
    fi

    rpc_hash=$(echo $rpc_res | jq '.hash')
    infura_hash=$(echo $infura_res | jq '.hash')

    if [ $rpc_hash != $infura_hash ]
    then
        echo "response_hash_not_equal"
        return 1
    fi

    echo "success"
    return 0
}

#echo "Test_eth_getLogs"
test_eth_getLogs(){
    #eth_getLogs
    data='{"jsonrpc":"2.0","method":"eth_getBlockByNumber","params":["0x2",false],"id":1}'
    run_test_logs $data
}

test_eth_getLogs_byBlockHash(){
    #eth_getLogs
    data='{"method":"eth_getLogs","params":[{"blockhash": "0xb84fc124c4209782fa5598b07daf70a1805241fb9a0e3635d13fa49fd74ca01c"}],"id":1,"jsonrpc":"2.0"}'
    run_test_logs $data
    return $?
}

test_eth_getLogs_byAddress(){
    #eth_getLogs
    data='{"method":"eth_getLogs","params":[{"address": "0x45dD91b0289E60D89Cec94dF0Aac3a2f539c514a"}],"id":1,"jsonrpc":"2.0"}'
    run_test_logs $data
    return $?
}

test_eth_getLogs_byAddress_fromto(){
    #eth_getLogs
    data='{"method":"eth_getLogs","params":[{"address": "0x45dD91b0289E60D89Cec94dF0Aac3a2f539c514a","fromBlock": "0xa","toBlock": "0xe"}],"id":1,"jsonrpc":"2.0"}' 
    run_test_logs $data
    return $?
}

