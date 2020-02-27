# generic-data-platform
GDP project is a dockerfile for building an opensource Hadoop Data Platform or ecosystem using modern components

## Instructions

1. Run the build.sh script. This script will ask you some input data and override the configurations for you. 
2. After that, you can run the docker build command. ie

~~~
docker build --rm -t matiaet98/gdp:latest .
~~~

3. Now you can spawn a container using the docker-compose provided in this project. You can edit the file or you can just run it using docker run like this:

~~~bash
docker run \
    --privileged \
    --network <network> \
    --ip <ip> \
    --name mygdp \
    --hostname mygdp.matinet \
    -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
    matiaet98/gdp:latest
~~~

3. Log in into the container:

~~~
docker exec -ti mygdp bash
~~~

4. Modify the script bootstrap.sh before running it: 
- You have to create some database users and change datasource configurations, otherwise some services will not start.
- Change datasource config in: /gdp/airflow/airflow.cfg
- Change datasource config in: /gdp/hive/conf/hive-site.xml
5. Run bootstrap.sh

- You can expose this ports:
    - 8080      **Spark Master**
    - 18080     **Spark History Server**
    - 8088      **YARN AM**
    - 9870      **HDFS Namenode Information**
    - 16010     **HBase Information**
    - 9090      **Airflow Web UI**
    - 8888      **Jupyterlab**
    - 8000      **NiFi Web UI**
    - 8090      **PrestoSQL Web UI**
    - 10002      **Hiveserver2 Web UI**

- You can mount this volumes:
    - /sys/fs/cgroup **required for systemd**
    - /data/dn **Datanode data**
    - /data/nn **Namenode data**
    - /data/zk  **Zookeeper data**
    - /data/presto  **PrestoSQL data**

## Software versions

- Apache Hadoop 3.2.1
- Apache Spark 3.0.0-preview2
- Apache HBase 2.2.3
- Apache Hive 3.1.2
- Apache Sqoop 1.4.7
- Apache Zookeeper 3.5.7
- PrestoSQL 330
- Apache NiFi 1.11.3
- Apache Kafka 2.4.0
- Apache Phoenix 5.0.0
- Apache Airflow 1.10.9
- JupyterLab 1.2.6
