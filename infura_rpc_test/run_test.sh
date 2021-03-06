#! /bin/bash
set +e

source setup.sh
source ./test/common.sh
source ./test/test_eth_getBlock.sh
source ./test/test_eth_getCode.sh
source ./test/test_eth_getLogs.sh
source ./test/test_eth_getTransaction.sh
source ./test/test_eth_getTransactionLogs.sh
source ./test/test_eth_getTransactionReceipt.sh


#eth_getBlock
err=$(test_eth_getBlockByNumber)
echo_res "test_eth_getBlockByNumber" $? $err

err=$(test_eth_getBlockByHash)
echo_res "test_eth_getLogs_byBlockHash" $? $err

err=$(test_eth_getBlockByHash_fulltx)
echo_res "test_eth_getLogs_byAddress" $? $err

err=$(test_eth_getBlockByHash_errBlockHash)
echo_res "test_eth_getBlockByHash_errBlockHash" $? $err

#eth_getCode
err=$(test_eth_getCode_byBlockNum)
echo_res "test_eth_getCode_byBlockNum" $? $err

err=$(test_eth_getCode_byBlockHash)
echo_res "test_eth_getCode_byBlockHash" $? $err

#eth_getlogs
err=$(test_eth_getLogs_byBlockHash)
echo_res "test_eth_getLogs_byBlockHash" $? $err

err=$(test_eth_getLogs_byAddress)
echo_res "test_eth_getLogs_byAddress" $? $err

err=$(test_eth_getLogs_byFromTo)
echo_res "test_eth_getLogs_byFromTo" $? $err

err=$(test_eth_getLogs_byTopic)
echo_res "test_eth_getLogs_byTopic" $? $err

# #eth_gettransaction
err=$(test_eth_getTransactionbyBlockNumberAndIndex)
echo_res "test_eth_getTransactionbyBlockNumberAndIndex" $? $err

err=$(test_eth_getTransactionbyBlockHashAndIndex)
echo_res "test_eth_getTransactionbyBlockHashAndIndex" $? $err

err=$(test_eth_getTransactionbyBlockNumberAndIndex_errBlockNum)
echo_res "test_eth_getTransactionbyBlockNumberAndIndex_errBlockNum" $? $err

err=$(test_eth_getTransactionbyBlockHashAndIndex_errBlockHash)
echo_res "test_eth_getTransactionbyBlockHashAndIndex_errBlockHash" $? $err

# #eth_getTransactionLogs
err=$(test_eth_getTransactionLogs)
echo_res "test_eth_getLogs_byAddress" $? $err

err=$(test_eth_getTransactionLogs_nullLogs)
echo_res "test_eth_getTransactionLogs_nullLogs" $? $err

err=$(test_eth_getTransactionLogs_errTxHash)
echo_res "test_eth_getTransactionLogs_errTxHash" $? $err

# #eth_getTransactionReceipt
err=$(test_eth_getTransactionReceipt)
echo_res "test_eth_getLogs_byAddress" $? $err

err=$(test_eth_getTransactionReceipt_errTxHash)
echo_res "test_eth_getTransactionReceipt_errTxHash" $? $err