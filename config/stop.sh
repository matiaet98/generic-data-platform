#!/bin/bash

systemctl stop zookeeper
systemctl stop hdfs
systemctl stop yarn
systemctl stop hbase
systemctl stop hive-metastore
systemctl stop spark
systemctl stop spark-history-server
systemctl stop jupyter
systemctl stop airflow-scheduler
systemctl stop airflow
systemctl stop presto
systemctl stop kafka
systemctl stop nifi