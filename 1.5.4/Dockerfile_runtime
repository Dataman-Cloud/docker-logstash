FROM demoregistry.dataman-inc.com/library/centos7-jdk8:latest

MAINTAINER Jinye Liu "jyliu@dataman-inc.com"

#logstash env
ENV LOGSTASH_VERSION="1.5.4"
ENV P_NAME logstash-${LOGSTASH_VERSION}
ENV LOGSTASH_INSTALL_HOME /opt/${P_NAME}
ENV LOGSTASH_HOME /usr/local/logstash

#install logstash
RUN curl https://download.elastic.co/logstash/logstash/${P_NAME}.tar.gz -o "/tmp/${P_NAME}.tar.gz" && \
    tar xzf /tmp/${P_NAME}.tar.gz -C /opt/ && \
    rm -f /tmp/${P_NAME}.tar.gz && \
    /bin/chmod -R 775 $LOGSTASH_INSTALL_HOME && \
    /bin/ln -s $LOGSTASH_INSTALL_HOME $LOGSTASH_HOME


# create dir
RUN mkdir -p /usr/local/logstash/conf

COPY entrypoint.sh /
COPY dataman.conf.temp /usr/local/logstash/conf/dataman.conf.temp
COPY logstash.json /usr/local/logstash/conf/logstash.json

RUN chmod +x /*.sh 
ENTRYPOINT ["/entrypoint.sh"]
