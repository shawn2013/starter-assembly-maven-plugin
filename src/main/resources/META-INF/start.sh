#!/usr/bin/env bash

server_root=`pwd`
classpath="$server_root/conf:`echo lib/*.jar | tr ' ' ':'`"
if test -e ${server_root}/conf/env ; then
    source ${server_root}/conf/env
fi

if [ -n "${mainclass}" ]; then
 	CUR_BUNDLE_NAME=${mainclass}
else
	echo "please set up mainclass in env"
	exit
fi

check(){
    RUNNING=`ps -F -p $PID|grep $PID|grep $CUR_BUNDLE_NAME`
    if [ ! -z "$RUNNING" ];
    then
        echo "$CUR_BUNDLE_NAME is already running..."
        exit 1
    fi
}
if [ -f pid ];
then
    PID=`cat pid`
    check
fi

#export JAVA_OPTS="$JAVA_OPTS -Dcom.sun.management.jmxremote.port=9527 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false"
#export JAVA_OPTS="$JAVA_OPTS -Dcom.sun.management.snmp.interface=0.0.0.0 -Dcom.sun.management.snmp.port=12345 -Dcom.sun.management.snmp.acl=false"
#export JAVA_OPTS="$JAVA_OPTS -server -Xms1024m -Xmx1024m -Xmn448m -Xss256K -XX:MaxPermSize=128m -XX:ReservedCodeCacheSize=64m"
#export JAVA_OPTS="$JAVA_OPTS -XX:+UseParallelGC -XX:+UseParallelOldGC -XX:ParallelGCThreads=2"
#export JAVA_OPTS="$JAVA_OPTS -XX:+PrintGCDetails -XX:+PrintGCTimeStamps"

echo "nohup java $JAVA_OPTS -cp ${classpath} ${mainclass} >> nohup.log 2>&1 &"
nohup java $JAVA_OPTS -cp ${classpath} ${mainclass} >> nohup.log 2>&1 &
echo $! > pid
