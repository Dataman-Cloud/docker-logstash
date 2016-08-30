#!/bin/bash
/filedownload.sh

cd /usr/local/logstash/conf
cp -f dataman.conf.temp dataman.conf

LOGSTASH_PORT=${LOGSTASH_PORT:-5011}
ES_HOST=${ES_HOST:-127.0.0.1}
ES_PORT=${ES_PORT:-9200}

sed -i 's/--LOGSTASH_PORT--/'$LOGSTASH_PORT'/g' dataman.conf
sed -i 's/--ES_HOST--/'$ES_HOST'/g' dataman.conf
sed -i 's/--ES_PORT--/'$ES_PORT'/g' dataman.conf

if [ "x$STDOUTNULL" == "xtrue" ];then
	echo "stdout output /dev/null."
	/usr/local/logstash/bin/logstash -f /usr/local/logstash/conf/dataman.conf >/dev/null
elif [ "x$LOGNULL" == "xtrue" ];then
	echo "stdout stderr output /dev/null."
	/usr/local/logstash/bin/logstash -f /usr/local/logstash/conf/dataman.conf &>/dev/null
else
	/usr/local/logstash/bin/logstash -f /usr/local/logstash/conf/dataman.conf
fi
