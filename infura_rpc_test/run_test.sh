#! /bin/bash
set +e

source setup.sh
source ./test/getResponse.sh
source ./test/test_eth_getBlock.sh
source ./test/test_eth_getCode.sh
source ./test/test_eth_getLogs.sh
source ./test/test_eth_getTransaction.sh
source ./test/test_eth_getTransactionLogs.sh
source ./test/test_eth_getTransactionReceipt.sh

echo_res(){
    if [ "$2" == "0" ];then
        echo "$1 success"
    else
         echo "$1 failed"
    fi

    if [ "$3" != "success" ]
    then 
        echo "err : $3"
    fi
}

#eth_getBlock
err=$(test_eth_getBlockByNumber)
echo_res "test_eth_getBlockByNumber" $? $err

err=$(test_eth_getBlockByHash)
echo_res "test_eth_getLogs_byBlockHash" $? $err

err=$(test_eth_getBlockByHash_fulltx)
echo_res "test_eth_getLogs_byAddress" $? $err


#eth_getCode

#err=$(test_eth_getCode_byBlockNum)
#echo_res "test_eth_getLogs_byAddress" $? $err

#err=$(test_eth_getCode_byBlockHash)
#echo_res "test_eth_getLogs_byAddress" $? $err

#eth_getlogs

#err=$(test_eth_getLogs)
#echo_res "test_eth_getLogs_byAddress" $? $err

#err=$(test_eth_getLogs_byBlockHash)
#echo_res "test_eth_getLogs_byAddress" $? $err

#err=$(test_eth_getLogs_byAddress)
#echo_res "test_eth_getLogs_byAddress" $? $err

# err=$(test_eth_getLogs_byAddress_fromto)
# echo_res "test_eth_getLogs_byAddress" $? $err

# #eth_gettransaction

err=$(test_eth_getTransactionbyBlockNumberAndIndex)
echo_res "test_eth_getLogs_byAddress" $? $err

err=$(test_eth_getTransactionbyBlockHashAndIndex)
echo_res "test_eth_getLogs_byAddress" $? $err

# #eth_getTransactionLogs

# err=$(test_eth_getTransactionLogs)
# echo_res "test_eth_getLogs_byAddress" $? $err

# #eth_getTransactionReceipt

# err=$(test_eth_getTransactionReceipt)
# echo_res "test_eth_getLogs_byAddress" $? $err