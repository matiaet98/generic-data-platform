# Todo list for GDP

## Security
There is no security in this image because it was intended for testing the data platform.
However it would be nice to have some kind of security in the future, that's the purpose of this section.

- [ ] Install Kerberos KDC and integrate all the components
- [ ] Install Apache Ranger and integrate all the components
- [ ] Test Ranger policies for access and data masking
- [ ] Configure Presto SSL/TLS, authentication and authorization
- [ ] Configure Airflow authentication and authorization

## Priority
- [ ] Install Kafdrop or some Kafka web visualizer
- [ ] Install Apache Superset for Data Visualization

## Others

- [ ] Install Solr
- [ ] Install Apache Knox
- [ ] Install Apache Atlas
- [ ] Test Apache hadoop Ozone (it's still in alpha stage)
- [ ] Install Ceph
- [ ] Install some kind of schema registry for Kafka and NiFi
- [ ] Create a branch without systemd dependency (we can use supervisord)
- [ ] Create a branch replacing Apache Kafka for Confluent Kafka