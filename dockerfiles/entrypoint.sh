#!/bin/bash
/filedownload.sh

cd /usr/local/logstash/conf
cp -f dataman.conf.temp dataman.conf

LOGSTASH_PORT=${LOGSTASH_PORT:-5011}
ES_HOST=${ES_HOST:-127.0.0.1}
ES_PORT=${ES_PORT:-9200}
LS_STDOUT_LEVEL=${LS_STDOUT_LEVEL:-""} # stdout { codec => rubydebug }
LS_WORKERS=${LS_WORKERS:-8}
LS_FLUSH_SIZE=${LS_FLUSH_SIZE:20000}
LS_IDLE_FLUSH_TIME=${LS_IDLE_FLUSH_TIME:-10}

sed -i 's/--LOGSTASH_PORT--/'$LOGSTASH_PORT'/g' dataman.conf
sed -i 's/--ES_HOST--/'$ES_HOST'/g' dataman.conf
sed -i 's/--ES_PORT--/'$ES_PORT'/g' dataman.conf
sed -i 's/--LS_STDOUT_LEVEL--/'$LS_STDOUT_LEVEL'/g' dataman.conf
sed -i 's/--LS_WORKERS--/'$LS_WORKERS'/g' dataman.conf
sed -i 's/--LS_FLUSH_SIZE--/'$LS_FLUSH_SIZE'/g' dataman.conf
sed -i 's/--LS_IDLE_FLUSH_TIME--/'$LS_IDLE_FLUSH_TIME'/g' dataman.conf

if [ "x$STDOUTNULL" == "xtrue" ];then
	echo "stdout output /dev/null."
	/usr/local/logstash/bin/logstash -f /usr/local/logstash/conf/dataman.conf >/dev/null
elif [ "x$LOGNULL" == "xtrue" ];then
	echo "stdout stderr output /dev/null."
	/usr/local/logstash/bin/logstash -f /usr/local/logstash/conf/dataman.conf &>/dev/null
else
	/usr/local/logstash/bin/logstash -f /usr/local/logstash/conf/dataman.conf
fi
