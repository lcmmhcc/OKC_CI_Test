#! /bin/bash

getResponse(){
    url=$1
    content=$2
    resp=$(curl -X POST $url -H "Content-Type: application/json" -d "$content")
    echo "$resp"
}
export -f getResponse
