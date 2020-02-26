#!/bin/bash

export JAVA_HOME=/usr/lib/jvm/java-1.8.0
export HADOOP_HOME=/mdp/hadoop
export HADOOP_CONF_DIR=/mdp/hadoop/etc/hadoop
export SPARK_HOME=/mdp/spark
export SPARK_CONF_DIR=/mdp/spark/conf
export HIVE_HOME=/mdp/hive
export HIVE_CONF_DIR=/mdp/hive/conf
export SQOOP_HOME=/mdp/sqoop
export AIRFLOW_HOME=/mdp/airflow
export PRESTO_HOME=/mdp/presto
export KAFKA_HOME=/mdp/kafka
export HBASE_HOME=/mdp/hbase
export PHOENIX_HOME=/mdp/phoenix
export PATH=$ZOOKEEPER_HOME/bin:$PATH
export PATH=$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PATH
export PATH=$SPARK_HOME/bin:$SPARK_HOME/sbin:$PATH
export PATH=$HIVE_HOME/bin:$PATH
export PATH=$SQOOP_HOME/bin:$PATH
export PATH=$PRESTO_HOME/bin:$PATH
export PATH=$KAFKA_HOME/bin:$PATH
export PATH=$HBASE_HOME/bin:$PATH
export PATH=$PHOENIX_HOME/bin:$PATH
export LD_LIBRARY_PATH=$HADOOP_HOME/lib/native:/usr/lib/oracle/19.6/client64/lib:$LD_LIBRARY_PATH
