FROM centos:latest
LABEL maintainer="matiaet98"
ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

WORKDIR /

RUN yum update -y && \
    yum install -y epel-release wget vim python3 python3-devel \
    java-1.8.0-openjdk java-1.8.0-openjdk-devel java-11-openjdk java-11-openjdk-devel \
    openssh-server python2-devel postgresql-server postgresql-devel openssh-clients \
    which net-tools sudo less gcc libnsl ncurses passwd git maven ant asciidoc cyrus-sasl-devel \
    cyrus-sasl-gssapi cyrus-sasl-plain gcc gcc-c++ krb5-devel libffi-devel libxml2-devel libxslt-devel \
    make mysql mysql-devel openldap-devel sqlite-devel gmp-devel \
    https://download.oracle.com/otn_software/linux/instantclient/19600/oracle-instantclient19.6-basic-19.6.0.0.0-1.x86_64.rpm \
    https://download.oracle.com/otn_software/linux/instantclient/19600/oracle-instantclient19.6-sqlplus-19.6.0.0.0-1.x86_64.rpm
    
RUN ln -s /bin/python3 /bin/python && \
    python3 -m pip install jupyterlab pandas numpy apache-airflow[hdfs,hive,jdbc,oracle,password,presto] py-postgresql psycopg2 pyspark cryptography

RUN useradd -m -G users,wheel hdfs && \
    useradd -m -G users,wheel,hdfs spark && \
    useradd -m -G users,wheel,hdfs hive && \
    usermod -a -G users,wheel postgres && \
    echo "root:root" | chpasswd && \
    echo "hdfs:hdfs" | chpasswd && \
    echo "spark:spark" | chpasswd && \
    echo "hive:hive" | chpasswd && \
    echo "postgres:postgres" | chpasswd && \
    ssh-keygen -b 4096 -P '' -f ~/.ssh/id_rsa && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
    su -c "ssh-keygen -b 4096 -P '' -f ~/.ssh/id_rsa" spark && \
    su -c "ssh-keygen -b 4096 -P '' -f ~/.ssh/id_rsa" hdfs && \
    su -c "ssh-keygen -b 4096 -P '' -f ~/.ssh/id_rsa" hive && \
    su -c "ssh-keygen -b 4096 -P '' -f ~/.ssh/id_rsa" postgres && \
    su -c "cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys" hdfs && \
    su -c "cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys" spark && \
    su -c "cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys" hive && \
    su -c "cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys" postgres && \
    mkdir -p /gdp && \
    mkdir -p /data/{dn,nn,zk,presto}

WORKDIR /gdp/

RUN wget https://archive.apache.org/dist/hadoop/common/hadoop-3.2.1/hadoop-3.3.1.tar.gz && \
    tar xfz hadoop-3.3.1.tar.gz && \
    rm -fr hadoop-3.3.1.tar.gz && \
    ln -s hadoop-3.3.1 hadoop
RUN wget https://archive.apache.org/dist/spark/spark-3.1.2/spark-3.1.2-bin-hadoop3.2.tgz && \
    tar xfz spark-3.0.0-bin-hadoop3.2.tgz && \
    rm -fr spark-3.0.0-bin-hadoop3.2.tgz && \
    ln -s spark-3.0.0-bin-hadoop3.2 spark
RUN wget https://archive.apache.org/dist/zookeeper/zookeeper-3.7.0/apache-zookeeper-3.7.0-bin.tar.gz && \
    tar xfz apache-zookeeper-3.7.0-bin.tar.gz && \
    rm -fr apache-zookeeper-3.7.0-bin.tar.gz && \
    ln -s apache-zookeeper-3.7.0-bin zookeeper
RUN wget https://archive.apache.org/dist/hive/hive-3.1.2/apache-hive-3.1.2-bin.tar.gz && \
    tar xfz apache-hive-3.1.2-bin.tar.gz && \
    rm -fr apache-hive-3.1.2-bin.tar.gz && \
    ln -s apache-hive-3.1.2-bin hive
RUN wget https://repo1.maven.org/maven2/io/trino/trino-server/358/trino-server-358.tar.gz && \
    wget https://repo1.maven.org/maven2/io/trino/trino-cli/358/trino-cli-358-executable.jar && \
    tar xfz trino-server-358.tar.gz && \
    rm -fr trino-server-358.tar.gz && \
    ln -s trino-server-358 presto
RUN wget https://archive.apache.org/dist/hbase/2.4.4/hbase-2.4.4-bin.tar.gz && \
    tar xfz hbase-2.4.4-bin.tar.gz && \
    rm -fr hbase-2.4.4-bin.tar.gz && \
    ln -s hbase-2.4.4 hbase
RUN wget http://www.apache.org/dyn/closer.lua/phoenix/phoenix-5.1.2/phoenix-hbase-2.4-5.1.2-bin.tar.gz && \
    tar xfz phoenix-hbase-2.4-5.1.2-bin.tar.gz && \
    rm -fr phoenix-hbase-2.4-5.1.2-bin.tar.gz && \
    ln -s phoenix-hbase-2.4-5.1.2-bin phoenix
RUN wget https://archive.apache.org/dist/kafka/2.8.0/kafka_2.13-2.8.0.tgz && \
    tar xfz kafka_2.13-2.8.0.tgz && \
    rm -fr kafka_2.13-2.8.0.tgz && \
    ln -s kafka_2.13-2.8.0 kafka
RUN wget https://archive.apache.org/dist/nifi/1.13.2/nifi-1.13.2-bin.tar.gz && \
    tar xfz nifi-1.13.2-bin.tar.gz && \
    rm -fr nifi-1.13.2-bin.tar.gz && \
    ln -s nifi-1.13.2 nifi
RUN wget https://maven.xwiki.org/externals/com/oracle/jdbc/ojdbc8/12.2.0.1/ojdbc8-12.2.0.1.jar && \ 
    cp /gdp/phoenix/*.jar /gdp/hbase/lib/ && \
    chmod +x presto-cli-330-executable.jar && \
    mv trino-cli-358-executable.jar presto/bin/presto && \
    cp ojdbc8-12.2.0.1.jar /gdp/hive/lib/ojdbc8.jar && \
    cp ojdbc8-12.2.0.1.jar /gdp/spark/jars/ojdbc8.jar && \
    rm -fr ojdbc8-12.2.0.1.jar && \
    rm -fr /gdp/hive/lib/guava-19.0.jar && \
    cp /gdp/hadoop/share/hadoop/common/lib/guava-27.0-jre.jar /gdp/hive/lib/ && \
    mkdir /gdp/notebooks && \
    mkdir /gdp/hive/tmp && \
    chown -R hdfs:hdfs /{gdp,data}

WORKDIR /

# Copy our configurations
COPY config/etc /etc
COPY config/usr /usr
COPY config/gdp/airflow /gdp/airflow
COPY config/gdp/hadoop/etc /gdp/hadoop/etc
COPY config/gdp/hbase/conf /gdp/hbase/conf
COPY config/gdp/hive/conf /gdp/hive/conf
COPY config/gdp/jupyter /gdp/jupyter
COPY config/gdp/kafka/config /gdp/kafka/config
COPY config/gdp/nifi/conf /gdp/nifi/conf
COPY config/gdp/presto/etc /gdp/presto/etc
COPY config/gdp/spark/conf /gdp/spark/conf
COPY config/gdp/zookeeper/conf /gdp/zookeeper/conf
COPY config/bootstrap.sh config/start.sh config/stop.sh /

RUN rm -fr /var/run/nologin

EXPOSE 8080 18080 8088 9870 16010 9090 8888 8000 8090 2181 9092 7077 9000
VOLUME ["/sys/fs/cgroup","/data/dn","/data/nn","/data/zk","/data/presto"]
CMD ["/usr/sbin/init"]
