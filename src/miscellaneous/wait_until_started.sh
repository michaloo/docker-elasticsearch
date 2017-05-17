#!/bin/bash
RET=1
while [[ RET -ne 0 ]]; do
    echo "Stalling for Elasticsearch..."
    curl -XGET -k -u "elastic:$$ELASTIC_PWD" "http://localhost:9200/" >/dev/null 2>&1
    RET=$?
    sleep 5
done
