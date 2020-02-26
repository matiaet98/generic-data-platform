#!/bin/bash

systemctl start zookeeper
systemctl start hdfs
systemctl start yarn
systemctl start hbase
systemctl start hive-metastore
systemctl start spark
systemctl start spark-history-server
systemctl start jupyter
systemctl start airflow-scheduler
systemctl start airflow
systemctl start presto
systemctl start kafka
systemctl start nifi