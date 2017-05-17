FROM elasticsearch:5.4.0

MAINTAINER Guillaume Simonneau <simonneaug@gmail.com>
LABEL Description="elasticsearch searchguard search-guard"

WORKDIR /usr/share/elasticsearch

# install modules
RUN bin/elasticsearch-plugin install -b com.floragunn:search-guard-5:5.4.0-12

COPY config ./config

# backup conf
RUN mkdir -p /.backup/elasticsearch/ \
&&  mv /usr/share/elasticsearch/config /.backup/elasticsearch/config

ADD ./src/ /run/
RUN chmod +x -R /run/

VOLUME /usr/share/elasticsearch/config
VOLUME /usr/share/elasticsearch/data

EXPOSE 9200 9300

# env
ENV CLUSTER_NAME="elasticsearch-default" \
    MINIMUM_MASTER_NODES=1 \
    HOSTS="127.0.0.1, [::1]" \
    NODE_NAME="node-default" \
    NODE_MASTER=true \
    NODE_DATA=true \
    NODE_INGEST=true \
    HTTP_ENABLE=true \
    HTTP_CORS_ENABLE=true \
    HTTP_CORS_ALLOW_ORIGIN=* \
    NETWORK_HOST="0.0.0.0" \
    ELASTIC_PWD="changeme" \
    KIBANA_PWD="changeme" \
    LOGSTASH_PWD="changeme" \
    BEATS_PWD="changeme" \
    HEAP_SIZE="1g" \
    CA_PWD="changeme" \
    TS_PWD="changeme" \
    KS_PWD="changeme" \
    HTTP_SSL=false

ENTRYPOINT ["/run/entrypoint.sh"]
CMD ["elasticsearch"]
