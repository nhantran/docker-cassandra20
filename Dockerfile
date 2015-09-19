FROM nhantran/oraclejdk17
MAINTAINER Nhan Tran <tranphanquocnhan@gmail.com>
ENV REFRESHED_AT 2015-05-06

RUN apt-get install -y python
RUN wget http://downloads.datastax.com/community/dsc-cassandra-2.0.14-bin.tar.gz
RUN tar xvf dsc-cassandra-2.0.14-bin.tar.gz
RUN rm dsc-cassandra-2.0.14-bin.tar.gz
RUN mv dsc-cassandra-2.0.14 /opt/cassandra
ENV CASSANDRA_HOME /opt/cassandra

RUN wget https://maven.java.net/content/repositories/releases/net/java/dev/jna/jna/4.1.0/jna-4.1.0.jar
RUN mv jna-4.1.0.jar $CASSANDRA_HOME/lib/jna.jar
RUN echo "root - memlock unlimited" >> /etc/security/limits.conf
RUN echo "root - nofile 100000" >> /etc/security/limits.conf
RUN echo "root - nproc 32768" >> /etc/security/limits.conf
RUN echo "root - as unlimited" >> /etc/security/limits.conf
RUN sysctl -p

ADD startCassandra $CASSANDRA_HOME/bin/
RUN chmod u+x $CASSANDRA_HOME/bin/startCassandra

RUN mkdir /opt/shared
VOLUME ["/opt/shared"]

EXPOSE 7000 7199 9042 9160 61621

ENTRYPOINT [ "/opt/cassandra/bin/startCassandra" ]

CMD ["1", "1"]
