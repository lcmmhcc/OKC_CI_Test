#! /bin/bash

test_eth_getTransactionLogs(){
    #eth_getLogs
    data="{\"jsonrpc\":\"2.0\",\"method\":\"eth_getTransactionLogs\",\"params\":[$txContractStoreHash],\"id\":1}"
    run_test_logs $data
}

test_eth_getTransactionLogs_nullLogs(){
    #eth_getLogs
    data="{\"jsonrpc\":\"2.0\",\"method\":\"eth_getTransactionLogs\",\"params\":[$txHash],\"id\":1}"
    run_test_logs $data
}

test_eth_getTransactionLogs_errTxHash(){
    #eth_getLogs
    data='{"jsonrpc":"2.0","method":"eth_getTransactionLogs","params":["0xfffffff84f2f7c99406a7a17c2831496c4c3d0c50f4d8285373c960d0811252b"],"id":1}'
    run_test_logs $data
}