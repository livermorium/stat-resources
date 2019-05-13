#!/bin/bash

function proc_net_dev_info_to_file(){

    # 初始化参数 进程id 与 输出内容文件名
    if [ $# -eq 0 ] || [ $# -gt 3 ]
    then
        echo "params: <pid> <interval_seconds (optional, default 10s)> <to_filename (optional, default proc.net.<pid>.data)>"
        exit -1
    fi

    local pid=$1

    if [ $# -gt 1 ]
    then
        local interval_seconds=$2
    else
        local interval_seconds=10
    fi

    if [ $# -eq 3 ]
    then
        local to_filename=$3
    else
        local to_filename="proc.net.${pid}.data"
    fi

    # title => 
    # Inter-|   Receive                                                |  Transmit
    # face |bytes    packets errs drop fifo frame compressed multicast|bytes    packets errs drop fifo colls carrier compressed
    cat /proc/${pid}/net/dev | head -2 > ${to_filename}

    # data
    while [ 1 == 1 ]
    do
        cat /proc/${pid}/net/dev | tail +3 >> ${to_filename}
        
        sleep ${interval_seconds} 
    done
}

proc_net_dev_info_to_file $*