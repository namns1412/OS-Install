#!/usr/bin/env bash

docker run --name zookeeper --network dev -itd -p 127.0.0.1:2181:2181 zookeeper:3.4.10

docker run --hostname kafka --name kafka --network dev -itd -p 127.0.0.1:9092:9092 -v /docker/kafka/data:/data -v /docker/kafka/logs:/logs -e ZOOKEEPER_IP=zookeeper -e KAFKA_ADVERTISED_HOST_NAME=kafka ches/kafka:0.10.2.1

docker run --name mongo --network dev -itd -p 27017:27017 -v /docker/mongo/db:/data/db mongo

docker run --name elastic --network dev -itd -p 9200:9200 -p 9300:9300 -e "http.host=0.0.0.0" -e "transport.host=127.0.0.1" -e 'xpack.security.enabled=false' -e 'xpack.monitoring.enabled=false' docker.elastic.co/elasticsearch/elasticsearch:5.3.1

docker run --name zipkin --network dev -itd -p 9411:9411 \
  -e STORAGE_TYPE='elasticsearch' \
  -e ES_HOSTS='http://elasticsearch:9200' \
  -e ES_INDEX='zipkin' \
  -e KAFKA_BOOTSTRAP_SERVERS='kafka:9092' \
  -e KAFKA_GROUP_ID='zipkin' \
  -e KAFKA_TOPIC='zipkin' \
  openzipkin/zipkin

docker run --name influxdb --network dev -itd -p 8086:8086 influxdb

run --name vault -itd --network dev -p 127.0.0.1:8200:8200 --cap-add=IPC_LOCK -v ~/Share/vault/file:/vault/file -v ~/Share/vault/logs:/vault/logs -e 'VAULT_LOCAL_CONFIG={"backend": {"file": {"path": "/vault/file"}}, "listener": {"tcp": {"address": "0.0.0.0:8200", "tls_disable": 1}}, "default_lease_ttl": "1168h", "max_lease_ttl": "1720h"}' vault server
