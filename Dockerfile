FROM centos:8 as centos8-with-systemd
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

FROM centos8-with-systemd
LABEL maintainer="matiaet98"

ENV container docker

WORKDIR /

RUN yum update -y && \
    yum install -y epel-release wget vim python3 python3-devel \
    java-1.8.0-openjdk java-1.8.0-openjdk-devel java-11-openjdk java-11-openjdk-devel \
    openssh-server python2-devel postgresql-server postgresql-devel openssh-clients \
    which net-tools sudo less gcc libnsl ncurses passwd git maven ant asciidoc cyrus-sasl-devel \
    cyrus-sasl-gssapi cyrus-sasl-plain gcc gcc-c++ krb5-devel libffi-devel libxml2-devel libxslt-devel \
    make mysql mysql-devel openldap-devel sqlite-devel gmp-devel \
    https://download.oracle.com/otn_software/linux/instantclient/19600/oracle-instantclient19.6-basic-19.6.0.0.0-1.x86_64.rpm \
    https://download.oracle.com/otn_software/linux/instantclient/19600/oracle-instantclient19.6-sqlplus-19.6.0.0.0-1.x86_64.rpm && \
    rm -fr /var/run/nologin && \
    ln -s /bin/python3 /bin/python && \
    python3 -m pip install jupyterlab pandas numpy apache-airflow[hdfs,hive,jdbc,oracle,password,presto] py-postgresql psycopg2 pyspark cryptography && \
    useradd -m -G users,wheel hdfs && \
    useradd -m -G users,wheel,hdfs spark && \
    useradd -m -G users,wheel,hdfs hive && \
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
    mkdir -p /mdp && \
    mkdir -p /data/{dn,nn,zk,presto} && \
    pushd /mdp/ && \
    wget http://apache.dattatec.com/hadoop/common/hadoop-3.2.1/hadoop-3.2.1.tar.gz && \
    wget http://apache.dattatec.com/spark/spark-3.0.0-preview2/spark-3.0.0-preview2-bin-hadoop3.2.tgz && \
    wget http://apache.dattatec.com/zookeeper/zookeeper-3.5.7/apache-zookeeper-3.5.7-bin.tar.gz && \
    wget http://apache.dattatec.com/hive/hive-3.1.2/apache-hive-3.1.2-bin.tar.gz && \
    wget https://maven.xwiki.org/externals/com/oracle/jdbc/ojdbc8/12.2.0.1/ojdbc8-12.2.0.1.jar && \
    wget http://apache.dattatec.com/sqoop/1.4.7/sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz && \
    wget https://repo1.maven.org/maven2/io/prestosql/presto-server/330/presto-server-330.tar.gz && \
    wget https://repo1.maven.org/maven2/io/prestosql/presto-cli/330/presto-cli-330-executable.jar && \
    wget http://apache.dattatec.com/hbase/2.2.3/hbase-2.2.3-bin.tar.gz && \
    wget http://apache.dattatec.com/phoenix/apache-phoenix-5.0.0-HBase-2.0/bin/apache-phoenix-5.0.0-HBase-2.0-bin.tar.gz && \
    wget http://apache.dattatec.com/kafka/2.4.0/kafka_2.12-2.4.0.tgz && \
    wget http://apache.dattatec.com/nifi/1.11.2/nifi-1.11.2-bin.tar.gz && \
    tar xfz hadoop-3.2.1.tar.gz && \
    tar xfz apache-zookeeper-3.5.7-bin.tar.gz && \
    tar xfz spark-3.0.0-preview2-bin-hadoop3.2.tgz && \
    tar xfz apache-hive-3.1.2-bin.tar.gz && \
    tar xfz sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz && \
    tar xfz presto-server-330.tar.gz && \
    tar xfz kafka_2.12-2.4.0.tgz && \
    tar xfz nifi-1.11.2-bin.tar.gz && \
    tar xfz hbase-2.2.3-bin.tar.gz && \
    tar xfz apache-phoenix-5.0.0-HBase-2.0-bin.tar.gz && \
    rm -fr apache-zookeeper-3.5.7-bin.tar.gz && \
    rm -fr hadoop-3.2.1.tar.gz && \
    rm -fr spark-3.0.0-preview2-bin-hadoop3.2.tgz && \
    rm -fr apache-hive-3.1.2-bin.tar.gz && \
    rm -fr sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz && \
    rm -fr presto-server-330.tar.gz && \
    rm -fr kafka_2.12-2.4.0.tgz && \
    rm -fr nifi-1.11.2-bin.tar.gz && \
    rm -fr hbase-2.2.3-bin.tar.gz && \
    rm -fr apache-phoenix-5.0.0-HBase-2.0-bin.tar.gz && \
    ln -s hadoop-3.2.1 hadoop && \
    ln -s spark-3.0.0-preview2-bin-hadoop3.2 spark && \
    ln -s apache-zookeeper-3.5.7-bin zookeeper && \
    ln -s apache-hive-3.1.2-bin hive && \
    ln -s sqoop-1.4.7.bin__hadoop-2.6.0 sqoop && \
    ln -s presto-server-330 presto && \
    ln -s kafka_2.12-2.4.0 kafka && \
    ln -s nifi-1.11.2 nifi && \
    ln -s hbase-2.2.3 hbase && \
    ln -s apache-phoenix-5.0.0-HBase-2.0-bin phoenix && \
    cp /mdp/phoenix/*.jar /mdp/hbase/lib/ && \
    chmod +x presto-cli-330-executable.jar && \
    mv presto-cli-330-executable.jar presto/bin/presto && \
    cp ojdbc8-12.2.0.1.jar /mdp/hive/lib/ojdbc8.jar && \
    cp ojdbc8-12.2.0.1.jar /mdp/spark/jars/ojdbc8.jar && \
    cp ojdbc8-12.2.0.1.jar /mdp/sqoop/lib/ojdbc8.jar && \
    rm -fr ojdbc8-12.2.0.1.jar && \
    rm -fr /mdp/hive/lib/guava-19.0.jar && \
    cp /mdp/hadoop/share/hadoop/common/lib/guava-27.0-jre.jar /mdp/hive/lib/ && \
    wget https://repo1.maven.org/maven2/com/carrotsearch/jdk19/commons-lang/2.6.1/commons-lang-2.6.1.jar -P /mdp/sqoop/lib/ && \
    mkdir /mdp/notebooks && \
    popd && \
    chown -R hdfs:hdfs /{mdp,data}

# Copy our configurations
COPY config/ /

EXPOSE 8080 18080 8088 9870 16010 9090 8888 8000 8090 2181 9092 7077 9000
VOLUME ["/sys/fs/cgroup","/data/dn","/data/nn","/data/zk","/data/presto"]

USER hdfs
CMD ["/usr/sbin/init"]