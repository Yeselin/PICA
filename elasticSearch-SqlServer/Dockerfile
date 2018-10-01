FROM docker.elastic.co/logstash/logstash:6.4.1

ENV HTTP_HOST=0.0.0.0
ENV XPACK_MONITORING_ELASTICSEARCH_URL=http://127.0.0.1:9200/
ENV XPACK_MONITORING_ENABLED=true
ENV PIPELINE_WORKERS=4
#ENV PIPELINE_BATCH_SIZE=5
#ENV PIPELINE_BATCH_DELAY=30
ENV LOG_LEVEL=info

COPY mssql-jdbc-7.0.0.jre8.jar /usr/share/logstash/pipeline
COPY logstash.conf /usr/share/logstash/pipeline

# Add your logstash plugins setup here
RUN logstash-plugin install logstash-input-jdbc

CMD ["-f", "/usr/share/logstash/pipeline/logstash.conf"]
