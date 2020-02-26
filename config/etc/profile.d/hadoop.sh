#!/bin/bash

export JAVA_HOME=/usr/lib/jvm/java-1.8.0
export HADOOP_HOME=/gdp/hadoop
export HADOOP_CONF_DIR=/gdp/hadoop/etc/hadoop
export SPARK_HOME=/gdp/spark
export SPARK_CONF_DIR=/gdp/spark/conf
export HIVE_HOME=/gdp/hive
export HIVE_CONF_DIR=/gdp/hive/conf
export SQOOP_HOME=/gdp/sqoop
export AIRFLOW_HOME=/gdp/airflow
export PRESTO_HOME=/gdp/presto
export KAFKA_HOME=/gdp/kafka
export HBASE_HOME=/gdp/hbase
export PHOENIX_HOME=/gdp/phoenix
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
