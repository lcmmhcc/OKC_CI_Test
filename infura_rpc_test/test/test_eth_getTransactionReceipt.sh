#! /bin/bash

run_test_txRecp(){
    data=$1
    onErr=$2
    errCode=$3

    rpc=$(getResponse $rpc_url $data)
    infura=$(getResponse $infura_url $data)

    if [ "$onErr" == "require_err" ]
    then
        require_err "$rpc" "$infura" "$errCode"
    else
        compare_txRecp_result "$rpc" "$infura"
    fi
}
# {
#     "jsonrpc": "2.0",
#     "id": 1,
#     "result": {
#         "status": "0x1",
#         "cumulativeGasUsed": "0x5208",
#         "logsBloom": "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
#         "logs": [],
#         "transactionHash": "0xf47b283e153dc1506432da71070898ba6823e456d2a4cf5a19b5b5fe2088ba42",
#         "contractAddress": null,
#         "gasUsed": "0x5208",
#         "blockHash": "0x170bcfaf4cfdb68150f1cc8e416d9a712d1b114daa02eeab5ff6f69321b1b08c",
#         "blockNumber": "0xb506",
#         "transactionIndex": "0x0",
#         "from": "0xbbE4733d85bc2b90682147779DA49caB38C0aA1F",
#         "to": "0x2727d250a14aa69fdcd702c82b314717aba4a6d0"
#     }
# }
compare_txRecp_result(){
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

    rpc_res_tx_status=$(echo $rpc_res | jq '.status')
    infura_res_tx_status=$(echo $infura_res | jq '.status')

    if [ $rpc_res_tx_status != $infura_res_tx_status ]
    then
        echo "response_tx_status_is_not_equal"
        return 1
    fi

    rpc_res_tx_from=$(echo $rpc_res | jq '.from')
    infura_res_tx_from=$(echo $infura_res | jq '.from')

    if [ $rpc_res_tx_from != $infura_res_tx_from ]
    then
        echo "response_tx_from_is_not_equal"
        return 1
    fi

    rpc_res_tx_to=$(echo $rpc_res | jq '.to')
    infura_res_tx_to=$(echo $infura_res | jq '.to')

    if [ $rpc_res_tx_to != $infura_res_tx_to ]
    then
        echo "response_tx_to_is_not_equal"
        return 1
    fi

    echo "success"
    return 0
}


test_eth_getTransactionReceipt(){
    #eth_getLogs
    data="{\"jsonrpc\":\"2.0\",\"method\":\"eth_getTransactionReceipt\",\"params\":[$txHash],\"id\":1}"
    run_test_txRecp "$data"
}

test_eth_getTransactionReceipt_errTxHash(){
    #eth_getLogs
    data='{"jsonrpc":"2.0","method":"eth_getTransactionReceipt","params":["0xffffffffffffacc65ba9ee658b04851eb6f4474a33ff95b6d7421ca008f1d22b"],"id":1}'
    run_test_txRecp "$data" "require_null"
}