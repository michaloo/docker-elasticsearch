#!/bin/bash

curl -XPUT -k -u "elastic:$$ELASTIC_PWD" 'http://localhost:9200/_all/_settings?preserve_existing=true' -d '{
    "index.auto_expand_replicas" : "0-all"
}'
