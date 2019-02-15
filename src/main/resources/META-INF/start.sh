#!/usr/bin/env bash

server_root=`pwd`
classpath="$server_root/conf:$server_root/webapp:`echo lib/*.jar | tr ' ' ':'`"
if test -e ${server_root}/conf/env ; then
    source ${server_root}/conf/env
fi

if [ -n "${mainclass}" ]; then
 	CUR_BUNDLE_NAME=${mainclass}
else
	echo "please set up mainclass in env"
	exit
fi

log_name=`date "+%Y%m%d"`
echo "nohup java $JAVA_OPTS -cp ${classpath} ${mainclass} >> log_"${log_name}".log 2>&1 &"
nohup java $JAVA_OPTS -cp ${classpath} ${mainclass} >> log_"${log_name}".log 2>&1 &
echo $! > pid
