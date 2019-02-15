#!/usr/bin/env bash

server_root=`pwd`
if test -e ${server_root}/conf/env ; then
    source ${server_root}/conf/env
fi

#
# check bundle name
#
if [ -n "${mainclass}" ]; then
 	CUR_BUNDLE_NAME=${mainclass}
else
	echo "please set up mainclass in env"
	exit
fi


if [ -n "$CUR_BUNDLE_NAME" ] ; then
    PIDS=`ps -ef | grep ${CUR_BUNDLE_NAME} | grep -v ' grep' | awk '{print $2}'`
    for f in `echo ${PIDS[@]}`; do
        echo "Find process and pid=["$f"]"
        kill -9 $f
        echo "Kill pid=["$f"] done"
    done
fi
