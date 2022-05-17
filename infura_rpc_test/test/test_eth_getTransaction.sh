#! /bin/bash

# {
#   "jsonrpc": "2.0",
#   "id": 1,
#   "result": {
#     "blockHash": "0x75a5808a4b7fec9b348fcc2c565f663c332f41cb66c1013dcd83fc741d2eb5f6",
#     "blockNumber": "0x2317",
#     "from": "0xbbe4733d85bc2b90682147779da49cab38c0aa1f",
#     "gas": "0x52080",
#     "gasPrice": "0x55ae82600",
#     "hash": "0x3448f61aa16bf905f8b3cdcc59ab40268350376379bf2a9addb9306cd4259930",
#     "input": "0x",
#     "nonce": "0xa",
#     "to": "0x2727d250a14aa69fdcd702c82b314717aba4a6d0",
#     "transactionIndex": "0x0",
#     "value": "0x16345785d8a0000",
#     "v": "0xe9",
#     "r": "0xf507240e412a57201040549c427f7d1629ea02344edf20828175c4e8ac112a5e",
#     "s": "0x34f848d15855646b6c98cd0df87ff371741c53c013f310b5199ed3d7641ae67b"
#   }
# }
run_test_tx(){
    data=$1
    rpc=$(getResponse $rpc_url $data)
    rpc_res=$(echo $rpc | jq '.result')
    rpc_err=$(echo $rpc | jq '.error|.message')
    #echo $rpc_res
    infura=$(getResponse $infura_url $data | jq '.result')
    infura_res=$(echo $infura | jq '.result')
    infura_err=$(echo $infura | jq '.error|.message')
    #echo $infura_res
    
   if [ ! -n "$rpc_err" ] 
    then
        echo "rpc_error_$rpc_err" | tr ' ' '_'
        return 1
    fi
    if [ ! -n "$infura_err" ] 
    then
        echo "infura_error_$infura_err" | tr ' ' '_'
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

    rpc_res_tx_hash=$(echo $rpc_res | jq '.hash')
    infura_res_tx_hash=$(echo $infura_res | jq '.hash')

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

    rpc_res_tx_value=$(echo $rpc_res | jq '.value')
    infura_res_tx_value=$(echo $infura_res | jq '.value')

    if [ $rpc_res_tx_value != $infura_res_tx_value ]
    then
        echo "response_tx_value_is_not_equal"
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


test_eth_getTransactionbyBlockNumberAndIndex(){
    #eth_getLogs
    data="{\"jsonrpc\":\"2.0\",\"method\":\"eth_getTransactionByBlockNumberAndIndex\",\"params\":[$txBlockNum,\"0x0\"],\"id\":1}"
    run_test_tx $data
}

test_eth_getTransactionbyBlockHashAndIndex(){
    #eth_getLogs
    data="{\"jsonrpc\":\"2.0\",\"method\":\"eth_getTransactionByBlockHashAndIndex\",\"params\":[$txBlockHash,\"0x0\"],\"id\":1}"
    run_test_tx $data
}

