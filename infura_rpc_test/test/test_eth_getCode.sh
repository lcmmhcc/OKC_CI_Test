#! /bin/bash
run_test_Code(){
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

test_eth_getCode_byBlockNum(){
    #eth_getLogs
    data='{"jsonrpc":"2.0","method":"eth_getCode","params": ["0x45dD91b0289E60D89Cec94dF0Aac3a2f539c514b", "0x0"],"id":1}'
    run_test_Code $data
}

test_eth_getCode_byBlockHash(){
    #eth_getLogs
    data='{"jsonrpc":"2.0","method":"eth_getCode","params": ["0x45dD91b0289E60D89Cec94dF0Aac3a2f539c514a", "0x9872a49f5d49e9c2b938a33015250a2059ce9d150243bca74a1f0b884222c162"],"id":1}' 
    run_test_Code $data
}