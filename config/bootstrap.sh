#!/bin/bash

# Before running this script, you need to setup database config for airflow and hive:
# Example using postgresql

# You need to create a database and user
# You can do this on postgres like this:
# su - postgres
# postgresql-setup --initdb
# edit /var/lib/pgsql/data/pg_hba.conf and change:
#local           all             all                             md5
#host            all             all     0.0.0.0/0               md5
#host            all             all     ::/0                    md5
#local           replication     all                             md5
#host            replication     all     0.0.0.0/0               md5
#host            replication     all     ::/0                    md5
# sudo systemctl enable postgresql
# sudo systemctl start postgresql
# createdb airflow
# createuser airflow
# psql airflow -c "alter user airflow with encrypted password 'airflow'"
# psql airflow -c "grant all privileges on database airflow to airflow;"
# psql airflow -c "alter role airflow set search_path = airflow,public;"
#
# Example for Oracle:
#
# CREATE USER "HIVE" IDENTIFIED BY "HIVE" DEFAULT TABLESPACE "USERS" TEMPORARY TABLESPACE "TEMP";
# ALTER USER "HIVE" QUOTA UNLIMITED ON "USERS";
# GRANT "CONNECT" TO "HIVE" ;
# GRANT "RESOURCE" TO "HIVE" ;



# Este script debe correrse con el usuario hdfs!!!

if [ "$(whoami)" != "hdfs" ]; then
        echo "Script must be run as user: hdfs"
        exit -1
fi

# Zookeeper
sudo systemctl enable zookeeper
sudo systemctl start zookeeper

# Hadoop
hdfs namenode -format
sudo systemctl enable hdfs
sudo systemctl start hdfs
hdfs dfs -mkdir /{user,tmp}
hdfs dfs -mkdir /user/{hdfs,spark,hive,root}
hdfs dfs -mkdir /user/hive/warehouse
hdfs dfs -mkdir /user/spark/logs
hdfs dfs -chgrp -R hdfs /
hdfs dfs -chmod -R g=rwx /
hdfs dfs -chown -R spark:hdfs /user/spark
hdfs dfs -chown -R hive:hdfs /user/hive
hdfs dfs -chown -R root:hdfs /user/root
sudo systemctl enable yarn
sudo systemctl start yarn

# Hbase 2 with Phoenix 5
sudo systemctl enable hbase
sudo systemctl start hbase


# Hive Metasore
# You have to edit the config in hive-site.xml to setup connection string, user and password for the metastore
# Then you also have to initialize the metastore. Edit dbType according to your config:

schematool -dbType oracle -initSchema
sudo systemctl enable metastore
sudo systemctl start metastore

# Spark with kafka package
sudo systemctl enable spark
sudo systemctl start spark
spark-shell --master local \
--packages org.apache.spark:spark-sql-kafka-0-10_2.12:3.0.0-preview2 \
<<EOF
:q
EOF
mv ~/.ivy2/jars/* /gdp/spark/jars/
sudo systemctl enable spark-history-server
sudo systemctl start spark-history-server

#Jupyterlab
sudo systemctl enable jupyter
sudo systemctl start jupyter

sudo systemctl enable airflow-scheduler
sudo systemctl enable airflow
sudo systemctl start airflow-scheduler
sudo systemctl start airflow

# PrestoSQL
sudo systemctl enable presto
sudo systemctl start presto

#Kafka
sudo systemctl enable kafka
sudo systemctl start kafka

# NiFi
sudo systemctl enable nifi
sudo systemctl start nifi
