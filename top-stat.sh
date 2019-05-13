#!/bin/bash

function top_pid_info_to_file(){

    # 初始化参数 进程id 与 输出内容文件名
    if [ $# -eq 0 ] || [ $# -gt 3 ]
    then
        echo "params: <pid> <interval_seconds (optional, default 5s)> <to_filename (optional, default top.<pid>.data)>"
        exit -1
    fi

    local pid=$1

    if [ $# -gt 1 ]
    then
        local interval_seconds=$2
    else
        local interval_seconds=5
    fi

    if [ $# -eq 3 ]
    then
        local to_filename=$3
    else
        local to_filename="top.${pid}.data"
    fi
    local_to_time_filename="time.${to_filename}"

    # title => PID USER      PR  NI %MEM    VIRT    RES    SHR S  %CPU     TIME+ COMMAND
    top -b -n 1 -p ${pid} | tail -2 | head -1 > ${to_filename}
    # top timestamp 
    echo "timestamp" > ${local_to_time_filename}


    # data
    while [ 1 == 1 ]
    do
        top -b -n 1 -p ${pid} | tail -1 >> ${to_filename}
        date +%s >> ${local_to_time_filename}
        
        sleep ${interval_seconds} 
    done
}

top_pid_info_to_file $*