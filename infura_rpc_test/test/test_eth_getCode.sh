#! /bin/bash
run_test_Code(){
    data=$1
    onErr=$2

    rpc=$(getResponse "$rpc_url" "$data")
    infura=$(getResponse "$infura_url" "$data")

    if [ "$onErr" == "require_err" ]
    then
        require_err "$rpc" "$infura" 
    elif [ "$onErr" == "require_null" ]
    then
        require_null "$rpc" "$infura" 
    else
        compare_code "$rpc" "$infura"
    fi
}
compare_code(){
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

    if [ $rpc_res != $infura_res ]
    then
        echo "response_code_is_not_equal"
        return 1
    fi

    echo "success"
    return 0
}

test_eth_getCode_byBlockNum(){
    #eth_getLogs
    data="{\"jsonrpc\":\"2.0\",\"method\":\"eth_getCode\",\"params\":[$contractAddr,\"0x0\"],\"id\":1}"
    run_test_Code "$data"
}

test_eth_getCode_byBlockHash(){
    #eth_getLogs
    data="{\"jsonrpc\":\"2.0\",\"method\":\"eth_getCode\",\"params\":[$contractAddr,$txContractDeployBlockHash],\"id\":1}" 
    run_test_Code "$data"
}